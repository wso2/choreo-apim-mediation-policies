public type OauthEndpointConfig record {|
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
