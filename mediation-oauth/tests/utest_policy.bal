import ballerina/test;
import ballerina/http;
import ballerina/time;
import choreo/mediation;

final string mockTokenEndpoint = string `http://localhost:9090/token`;

service /token on new http:Listener(9090) {
    resource function post .(http:Caller caller, http:Request req) returns error? {
        json payload = {
            "access_token": "eyJ4NXQiOiJPcmNycTdfU2FEYVE4ejFFUE1EWWowcENyQm8iLCJraWQiOiJZV05pTm1KallqbGtObU5pWkRkaVpUWTRaREF3WlRNNU5HRmpOVE16WWpBNFlqQTFPR0V4TkRjMll6bGxaREEwWm1Jd01qTTVOMlE1WlRFeE9EWTNOd19SUzI1NiIsInR5cCI6ImF0K2p3dCIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiI3MXpfWHd2SXhnNm9ZcERpY0NlMmp3SWRJNzRhIiwiYXV0IjoiQVBQTElDQVRJT04iLCJhdWQiOlsiNzF6X1h3dkl4ZzZvWXBEaWNDZTJqd0lkSTc0YSIsImNob3JlbzpkZXBsb3ltZW50OnNhbmRib3giXSwibmJmIjoxNzQyODg4Mzk4LCJhenAiOiI3MXpfWHd2SXhnNm9ZcERpY0NlMmp3SWRJNzRhIiwib3JnX2lkIjoiZTdjZWQzOGUtMjZlNi00ODIxLTkwYzYtYTFmYzE4NzBjMDJhIiwiaXNzIjoiaHR0cHM6XC9cL2FwaS5hc2dhcmRlby5pb1wvdFwvdW1hMTIzXC9vYXV0aDJcL3Rva2VuIiwiZXhwIjoxNzQyODg5Mjk4LCJvcmdfbmFtZSI6InVtYTEyMyIsImlhdCI6MTc0Mjg4ODM5OCwianRpIjoiZDgxMWE1MTMtOTljOC00NTUxLWIwY2MtNmYwYzE3NDEzNmNmIiwiY2xpZW50X2lkIjoiNzF6X1h3dkl4ZzZvWXBEaWNDZTJqd0lkSTc0YSJ9.gcHKeUwx_lnNErdxr1jquy3HsJiyn2NW3_XG09yyiDgXFws9CJii5Bcn_kytvrAf4n1qudcYanAjDRNHPc0adJ6kutmgzqBFeTXXtDM1EkwPE0AXfWsV-RmNMDqv18XgSGvFlhxnBFya0HUozkSrVQEABlu-ScF81453GVblYEDJjVuz78vHd9kDHsS_jXPUe-Ormww3XYsXSGP64Qlau6HDp8JDMT8EGd9KwC0T-T8pUouRGQK5NAYRIXgV6Quosc0HxmWkfqiH4snTYiV3X6o3skHH-JUNxOq6UBYV1Dpoe5OYMRwo_zaYLuyVPqVL5e2b2J02rxbSVD0l1HWpDw",
            "token_type": "at+jwt",
            "expires_in": 3600
        };

        http:Response response = new;
        response.setPayload(payload.toJson());
        response.setHeader("Content-Type", "application/json");

        check caller->respond(response);
    }
}

configurable string testClientId = "71z_XwvIxg6oYpDifjfe2jwIdI74a";
configurable string testClientSecret = "bqBe_HZGBjklryRfshysAzvn_fUJcywyo4mmhlk5Zg4a";
configurable string testHeaderName = "Authorization";

OauthEndpointConfig endpoint = {
    tokenApiUrl: mockTokenEndpoint,
    clientId: testClientId,
    clientSecret: testClientSecret
};

function createContext(string httpMethod, string resPath) returns mediation:Context {
    mediation:ResourcePath originalPath = checkpanic mediation:createImmutableResourcePath(resPath);
    mediation:Context originalCtx =
        mediation:createImmutableMediationContext(httpMethod, originalPath.pathSegments(), {}, {});
    mediation:ResourcePath mutableResPath = checkpanic mediation:createMutableResourcePath(resPath);
    return mediation:createMutableMediationContext(originalCtx, mutableResPath.pathSegments(), {}, {});
}

@test:Config {}
function testOAuthInSuccess() returns error? {
    mediation:Context ctx = createContext("get", "/greet");
    http:Request req = new;

    http:Response|error|false? result = oauthIn(
        ctx,
        req,
        mockTokenEndpoint,
        testClientId,
        testClientSecret,
        testHeaderName
    );

    test:assertTrue(result is (), "Expected nil response");
    string|error headerValue = req.getHeader(testHeaderName);

    test:assertTrue(headerValue is string, "Header should be present");

    if (headerValue is string && testHeaderName == "Authorization") {
        test:assertTrue(headerValue.startsWith("Bearer "), "Header should contain a valid token");
    }

}

@test:Config {}
function testGetValidTokenWithCache() returns error? {
    TokenResponse token1 = check getValidToken(endpoint);
    TokenResponse token2 = check getValidToken(endpoint);
    test:assertEquals(token2, token1, "Cached token mismatch");
}

@test:Config {}
function testGenerateNewToken() returns error? {
    TokenResponse token = check generateNewToken(endpoint);
    test:assertEquals(token.accessToken, "eyJ4NXQiOiJPcmNycTdfU2FEYVE4ejFFUE1EWWowcENyQm8iLCJraWQiOiJZV05pTm1KallqbGtObU5pWkRkaVpUWTRaREF3WlRNNU5HRmpOVE16WWpBNFlqQTFPR0V4TkRjMll6bGxaREEwWm1Jd01qTTVOMlE1WlRFeE9EWTNOd19SUzI1NiIsInR5cCI6ImF0K2p3dCIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiI3MXpfWHd2SXhnNm9ZcERpY0NlMmp3SWRJNzRhIiwiYXV0IjoiQVBQTElDQVRJT04iLCJhdWQiOlsiNzF6X1h3dkl4ZzZvWXBEaWNDZTJqd0lkSTc0YSIsImNob3JlbzpkZXBsb3ltZW50OnNhbmRib3giXSwibmJmIjoxNzQyODg4Mzk4LCJhenAiOiI3MXpfWHd2SXhnNm9ZcERpY0NlMmp3SWRJNzRhIiwib3JnX2lkIjoiZTdjZWQzOGUtMjZlNi00ODIxLTkwYzYtYTFmYzE4NzBjMDJhIiwiaXNzIjoiaHR0cHM6XC9cL2FwaS5hc2dhcmRlby5pb1wvdFwvdW1hMTIzXC9vYXV0aDJcL3Rva2VuIiwiZXhwIjoxNzQyODg5Mjk4LCJvcmdfbmFtZSI6InVtYTEyMyIsImlhdCI6MTc0Mjg4ODM5OCwianRpIjoiZDgxMWE1MTMtOTljOC00NTUxLWIwY2MtNmYwYzE3NDEzNmNmIiwiY2xpZW50X2lkIjoiNzF6X1h3dkl4ZzZvWXBEaWNDZTJqd0lkSTc0YSJ9.gcHKeUwx_lnNErdxr1jquy3HsJiyn2NW3_XG09yyiDgXFws9CJii5Bcn_kytvrAf4n1qudcYanAjDRNHPc0adJ6kutmgzqBFeTXXtDM1EkwPE0AXfWsV-RmNMDqv18XgSGvFlhxnBFya0HUozkSrVQEABlu-ScF81453GVblYEDJjVuz78vHd9kDHsS_jXPUe-Ormww3XYsXSGP64Qlau6HDp8JDMT8EGd9KwC0T-T8pUouRGQK5NAYRIXgV6Quosc0HxmWkfqiH4snTYiV3X6o3skHH-JUNxOq6UBYV1Dpoe5OYMRwo_zaYLuyVPqVL5e2b2J02rxbSVD0l1HWpDw", "Incorrect access token");
    test:assertEquals(token.tokenType, "at+jwt", "Incorrect token type");
    test:assertEquals(token.expiresIn, 3600, "Incorrect expires_in");
    test:assertTrue(token.validTill > time:utcNow()[0], "Invalid token expiry time");
}

@test:Config {}
function testGenerateNewTokenWhenRemainFiveMin() returns error? {
    TokenResponse token = {
        "accessToken": "eyJ4NXQiOiJPcmNycTdfU2FEYVE4ejefgjinnffgvjhviOiJZV05pTm1KallqbGtObU5pWkRkaVpUWTRaREF3WlRNNU5HRmpOVE16WWpBNFlqQTFPR0V4TkRjMll6bGxaREEwWm1Jd01qTTVOMlE1WlRFeE9EWTNOd19SUzI1NiIsInR5cCI6ImF0K2p3dCIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiI3MXpfWHd2SXhnNm9ZcERpY0NlMmp3SWRJNzRhIiwiYXV0IjoiQVBQTElDQVRJT04iLCJhdWQiOlsiNzF6X1h3dkl4ZzZvWXBEaWNDZTJqd0lkSTc0YSIsImNob3JlbzpkZXBsb3ltZW50OnNhbmRib3giXSwibmJmIjoxNzQyODg4Mzk4LCJhenAiOiI3MXpfWHd2SXhnNm9ZcERpY0NlMmp3SWRJNzRhIiwib3JnX2lkIjoiZTdjZWQzOGUtMjZlNi00ODIxLTkwYzYtYTFmYzE4NzBjMDJhIiwiaXNzIjoiaHR0cHM6XC9cL2FwaS5hc2dhcmRlby5pb1wvdFwvdW1hMTIzXC9vYXV0aDJcL3Rva2VuIiwiZXhwIjoxNzQyODg5Mjk4LCJvcmdfbmFtZSI6InVtYTEyMyIsImlhdCI6MTc0Mjg4ODM5OCwianRpIjoiZDgxMWE1MTMtOTljOC00NTUxLWIwY2MtNmYwYzE3NDEzNmNmIiwiY2xpZW50X2lkIjoiNzF6X1h3dkl4ZzZvWXBEaWNDZTJqd0lkSTc0YSJ9.gcHKeUwx_lnNErdxr1jquy3HsJiyn2NW3_XG09yyiDgXFws9CJii5Bcn_kytvrAf4n1qudcYanAjDRNHPc0adJ6kutmgzqBFeTXXtDM1EkwPE0AXfWsV-RmNMDqv18XgSGvFlhxnBFya0HUozkSrVQEABlu-ScF81453GVblYEDJjVuz78vHd9kDHsS_jXPUe-Ormww3XYsXSGP64Qlau6HDp8JDMT8EGd9KwC0T-T8pUouRGQK5NAYRIXgV6Quosc0HxmWkfqiH4snTYiV3X6o3skHH-JUNxOq6UBYV1Dpoe5OYMRwo_zaYLuyVPqVL5e2b2J02rxbSVD0l1HWpDw",
        "tokenType": "at+jwt",
        "expiresIn": 900,
        "validTill": time:utcNow()[0] + 300,
        "refreshToken": "eyJ4NXQiOiJPcmNycTdfU2FEYVE4ejFFUE1EWWowcENyQm8iLCJraWQiOiJZV05pTm1KallqbGtObU5pWkRkaVpUWTRaREF3WlRNNU5HRmpOVE16WWpBNFlqQTFPR0V4TkRjMll6bGxaREEwWm1Jd01qTTVOMlE1WlRFeE9EWTNOd19SUzI1NiIsInR5cCI6ImF0K2p3dCIsImFsZyI6IlJTMjU2In0"
    };

    oauthAccessToken = token;
    TokenResponse token1 = check getValidToken(endpoint);
    test:assertNotEquals(token1.accessToken, token.accessToken, "Cached token and generated tocken are matched");
}

@test:BeforeSuite
function startMockServer() {
}
