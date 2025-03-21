import ballerina/http;
import choreo/mediation;
import ballerina/time;
import ballerina/log;
import ballerina/cache;

type OAuthEndpoint record {|
    string id;
    string tokenApiUrl;
    string clientId;
    string clientSecret;
|};

public type TokenResponse record {|
    string accessToken;
    string refreshToken?;
    string tokenType;
    int expiresIn;
    int validTill;
|};

public class TokenCacheManager {
    private cache:Cache tokenCache;

    public function init() {
        self.tokenCache = new (capacity = 100, evictionFactor = 0.2);
    }

     public function getToken(string id) returns TokenResponse? {
        any|error cachedItem = self.tokenCache.get(id);
        if (cachedItem is error) {
            log:printDebug("No token in cache for ID: " + id);
            return ();
        }
        return <TokenResponse>cachedItem;
    }

    public function putToken(string id, TokenResponse token) {
        error? result = self.tokenCache.put(id, token);
        if result is error {
            log:printError("Failed to cache token", 'error = result);
        }
    }

    public function removeToken(string id) {
        error? result = self.tokenCache.invalidate(id);
        if (result is error) {
            log:printError("Failed to remove token from cache", 'error = result);
        }
    }
}

final TokenCacheManager tokenCacheManager = new TokenCacheManager();

http:Client tokenClient = check new("https://example.com/oauth2/token");

@mediation:RequestFlow
public function oauthIn(mediation:Context ctx, http:Request req,
                        string tokenEndpointUrl, string clientId, string clientSecret, string headerName)
                        returns http:Response|false|error? {

    string endpointId = generateEndpointId(tokenEndpointUrl, clientId);
    
    OAuthEndpoint oauthEndpoint = {
        tokenApiUrl: tokenEndpointUrl,
        clientId: clientId,
        clientSecret: clientSecret,
        id: endpointId
    };
    
    http:Client|error tokenClientResult = new(tokenEndpointUrl);
    if (tokenClientResult is error) {
        log:printError("Failed to initialize token client", 'error = tokenClientResult);
        return error("Failed to initialize token client");
    }
    tokenClient = tokenClientResult;

    TokenResponse token = check getValidToken(oauthEndpoint);
    string authorizationHeader = headerName == "Authorization" ? "Bearer " + token.accessToken : token.accessToken;
    req.setHeader(headerName, authorizationHeader);
    
    return;
}

@mediation:ResponseFlow
public function oauthOut(mediation:Context ctx, http:Request req, http:Response response,
                         string tokenEndpointUrl, string clientId, string clientSecret, string header)
                         returns http:Response|false|error? {

    if (response.statusCode == 401) {
        log:printError("Received 401 Unauthorized response");
        return error("Unauthorized response from backend");
    }
    return;
}

@mediation:FaultFlow
public function oauthFault(mediation:Context ctx, http:Request req, http:Response? res, http:Response errFlowRes, error e,
                           string tokenEndpointUrl, string clientId, string clientSecret, string header)
                           returns http:Response|false|error? {

    log:printError("OAuth mediation fault occurred", 'error = e);
    return errFlowRes;
}

function getValidToken(OAuthEndpoint oauthEndpoint) returns TokenResponse|error {
    TokenResponse? cachedToken = tokenCacheManager.getToken(oauthEndpoint.id);

    if (cachedToken is TokenResponse) {
        int currentTimeInSeconds = time:utcNow()[0];
        int tokenExpiryBuffer = 300; 

        if (cachedToken.validTill - currentTimeInSeconds > tokenExpiryBuffer) {
            return cachedToken;
        }

        if (cachedToken.refreshToken is string) {
            TokenResponse|error refreshResult = refreshToken(oauthEndpoint, <string>cachedToken.refreshToken);
            if (refreshResult is TokenResponse) {
                return refreshResult;
            }
            log:printError("Token refresh failed. Generating a new token.", 'error = refreshResult);
        }
    }
    
    return generateNewToken(oauthEndpoint);
}

function generateNewToken(OAuthEndpoint endpoint) returns TokenResponse|error {
    http:Request tokenReq = new;
    tokenReq.setHeader("Content-Type", "application/x-www-form-urlencoded");
    
    string payload = string `grant_type=client_credentials&client_id=${endpoint.clientId}&client_secret=${endpoint.clientSecret}`;
    tokenReq.setTextPayload(payload);
    
    TokenResponse token = check requestAndParseToken(tokenReq);
    tokenCacheManager.putToken(endpoint.id, token);
    return token;
}

function refreshToken(OAuthEndpoint endpoint, string refreshToken) returns TokenResponse|error {
    if (refreshToken == "") {
        return error("Refresh token is empty");
    }

    http:Request tokenReq = new;
    tokenReq.setHeader("Content-Type", "application/x-www-form-urlencoded");

    string payload = string `grant_type=refresh_token&refresh_token=${refreshToken}&client_id=${endpoint.clientId}&client_secret=${endpoint.clientSecret}`;
    tokenReq.setTextPayload(payload);
    
    TokenResponse token = check requestAndParseToken(tokenReq);
    tokenCacheManager.putToken(endpoint.id, token);
    return token;
}

function requestAndParseToken(http:Request tokenReq) returns TokenResponse|error {
    http:Response|error tokenRespResult = tokenClient->post("", tokenReq);
    if (tokenRespResult is error) {
        return error("Error calling token endpoint: " + tokenRespResult.message());
    }

    http:Response tokenResp = tokenRespResult;

    json|error respJson = tokenResp.getJsonPayload();
    if (respJson is error) {
        return error("Failed to parse token response: " + respJson.message());
    }

    int currentTime = time:utcNow()[0];
    int expiresIn = check respJson.expires_in;

    TokenResponse token = {
        accessToken: check respJson.access_token,
        tokenType: check respJson.token_type,
        expiresIn: expiresIn,
        validTill: currentTime + expiresIn
    };

    if respJson.refresh_token is string && respJson.refresh_token != ""{
        token.refreshToken = check respJson.refresh_token;
    } else {
        log:printDebug("No refresh_token in response");
    }

    return token;
}

function generateEndpointId(string tokenUrl, string clientId) returns string {
    return string `${tokenUrl}:${clientId}`;
}
