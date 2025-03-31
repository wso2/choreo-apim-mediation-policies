import ballerina/http;
import choreo/mediation;
import ballerina/time;
import ballerina/log;
import ballerina/lang.runtime;
import ballerina/mime;
import ballerina/lang.regexp;

TokenResponse? oauthAccessToken = ();
http:Client? tokenClient = ();

function getTokenClient(string tokenEndpointUrl) returns http:Client|error {
    if (tokenClient is http:Client) {
        return <http:Client>tokenClient;
    }

    lock {
        if (tokenClient is http:Client) {
            return <http:Client>tokenClient;
        }

        http:Client|error tokenClientResult = new (tokenEndpointUrl, {
            timeout: 120
        });

        if (tokenClientResult is error) {
            return error("Failed to initialize token client for URL: " + tokenEndpointUrl, tokenClientResult);
        } else {
            tokenClient = tokenClientResult;
            return tokenClientResult;
        }
    }
}

@mediation:RequestFlow
public function oauthIn(mediation:Context ctx,
        http:Request req,
        string tokenEndpointUrl,
        string clientId,
        string clientSecret,
        string headerName)
                        returns http:Response|false|error? {

    OauthEndpointConfig oauthEndpointConfig = {
        tokenApiUrl: tokenEndpointUrl,
        clientId: clientId,
        clientSecret: clientSecret
    };

    TokenResponse|error token = check getValidToken(oauthEndpointConfig);
    if (token is error) {
        return error("Failed to get a valid token", 'error = token);
    }

    string headerValue = string `Bearer ${token.accessToken}`;
    req.setHeader(headerName, headerValue);

    return;
}

function isValidToken() returns boolean {
    TokenResponse? cachedToken = oauthAccessToken;

    if (cachedToken is TokenResponse) {
        int currentTimeInSeconds = time:utcNow()[0];
        int tokenExpiryBuffer = 300;

        if (cachedToken.validTill - currentTimeInSeconds > tokenExpiryBuffer) {
            return true;
        }
    }
    return false;
}

function getValidToken(OauthEndpointConfig oauthEndpointConfig) returns TokenResponse|error {
    TokenResponse? cachedToken = oauthAccessToken;
    if (cachedToken is TokenResponse) {
        if (isValidToken()) {
            return cachedToken;
        }
    }

    lock {
        if (cachedToken is TokenResponse) {
            if (isValidToken()) {
                return cachedToken;
            }
        }

        if (cachedToken is TokenResponse && cachedToken.refreshToken is string && cachedToken.refreshToken != "") {
            TokenResponse|error refreshResult = refreshToken(oauthEndpointConfig, <string>cachedToken.refreshToken);
            if (refreshResult is TokenResponse) {
                return refreshResult;
            }
            log:printError("Token refresh failed. Generating a new token.", 'error = refreshResult);
        }

        TokenResponse|error newToken = generateNewToken(oauthEndpointConfig);
        if newToken is error {
            return error("Failed to generate new token", 'error = newToken);
        }
        oauthAccessToken = newToken;
        return newToken;
    }

}

function generateNewToken(OauthEndpointConfig oauthEndpointConfig) returns TokenResponse|error {
    http:Request tokenReq = new;
    tokenReq.setHeader("Content-Type", "application/x-www-form-urlencoded");

    string authString = oauthEndpointConfig.clientId + ":" + oauthEndpointConfig.clientSecret;
    string encodedCredentials = (check mime:base64Encode(authString)).toString();
    string encodedCreds = regexp:replaceAll(re `\s+`, encodedCredentials, "");
    string authHeader = string `Basic ${encodedCreds}`;
    tokenReq.setHeader("Authorization", authHeader);

    string payload = "grant_type=client_credentials";
    tokenReq.setTextPayload(payload);

    TokenResponse|error token = check requestAndParseToken(tokenReq, oauthEndpointConfig.tokenApiUrl);
    if token is error {
        return error("Failed to generate new token from " + oauthEndpointConfig.tokenApiUrl, token);
    }
    return token;
}

function refreshToken(OauthEndpointConfig oauthEndpointConfig, string refreshToken) returns TokenResponse|error {
    if (refreshToken == "") {
        return error("Refresh token is empty");
    }
    http:Request tokenReq = new;
    tokenReq.setHeader("Content-Type", "application/x-www-form-urlencoded");

    string authString = oauthEndpointConfig.clientId + ":" + oauthEndpointConfig.clientSecret;
    string encodedCredentials = (check mime:base64Encode(authString)).toString();
    string encodedCreds = regexp:replaceAll(re `\s+`, encodedCredentials, "");
    string authHeader = string `Basic ${encodedCreds}`;
    tokenReq.setHeader("Authorization", authHeader);

    string payload = string `grant_type=refresh_token&refresh_token=${refreshToken}`;
    tokenReq.setTextPayload(payload);

    TokenResponse|error token = check requestAndParseToken(tokenReq, oauthEndpointConfig.tokenApiUrl);
    if token is error {
        return error("Failed to generate new token from " + oauthEndpointConfig.tokenApiUrl, token);
    }
    return token;
}

function requestAndParseToken(http:Request tokenReq, string tokenEndpointUrl) returns TokenResponse|error {
    int maxRetries = 3;
    int retryCount = 0;
    decimal initialBackoff = 5;
    http:Response? tokenResp = ();
    error? lastError = ();

    http:Client|error tokenClientResult = getTokenClient(tokenEndpointUrl);
    if (tokenClientResult is error) {
        return error("Failed to initialize token client", 'error = tokenClientResult);
    }

    while retryCount < maxRetries {
        http:Response|http:ClientError tokenRespResult = tokenClientResult->post("", tokenReq);

        if tokenRespResult is http:Response {
            tokenResp = tokenRespResult;
            break;
        } else {
            if (tokenRespResult is http:IdleTimeoutError || tokenRespResult is http:RemoteServerError) {
                lastError = tokenRespResult;
                retryCount += 1;
                log:printWarn(string `Token request failed (${tokenRespResult.message()}). Retrying ${retryCount}`);

                if retryCount < maxRetries {
                    decimal backoffTime = initialBackoff * (2 ^ (retryCount - 1));
                    runtime:sleep(backoffTime);
                } else {
                    return error("Error calling token endpoint after maximum retries");
                }
            } else {
                return error("Unexpected error calling token endpoint");
            }
        }
    }
    if tokenResp is () {
        return error("Failed to receive a token response after retries", lastError);
    }

    if (tokenResp.statusCode == http:STATUS_OK || tokenResp.statusCode == http:STATUS_CREATED) {
        json|error respJson = tokenResp.getJsonPayload();
        if (respJson is error) {
            return error("Failed to parse token response: " + respJson.message());
        } else {
            var accessTokenJson = respJson.access_token;
            var tokenTypeJson = respJson.token_type;
            var expiresInJson = respJson.expires_in;

            if (accessTokenJson is ()) || (tokenTypeJson is ()) || (expiresInJson is ()) {
                return error("Missing required fields in token response");
            }

            int currentTime = time:utcNow()[0];
            int expiresIn = check respJson.expires_in;

            TokenResponse token = {
                accessToken: check respJson.access_token,
                tokenType: check respJson.token_type,
                expiresIn: expiresIn,
                validTill: currentTime + expiresIn
            };

            // json|error refreshTokenJson = check respJson.refresh_token;
            // if (refreshTokenJson is json && refreshTokenJson != "") {
            //     token.refreshToken = check refreshTokenJson;
            // }
            return token;
        }
    } else {
        log:printInfo("Token endpoint returned non-200 status.", 'error = lastError);
        return error("Token endpoint returned non-200 status.");

    }

}
