// Copyright (c) 2025 WSO2 LLC (http://www.wso2.org) All Rights Reserved.
//
// WSO2 LLC licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import choreo/mediation;

TokenResponse? oauthAccessToken = ();
http:Client? tokenClient = ();

@mediation:RequestFlow
public function oauthIn(mediation:Context ctx,
        http:Request req,
        string tokenEndpointUrl,
        string clientId,
        string clientSecret,
        string headerName="Authorization")
                        returns http:Response|false|error? {

    OauthEndpointConfig oauthEndpointConfig = {
        tokenApiUrl: tokenEndpointUrl,
        clientId: clientId,
        clientSecret: clientSecret
    };

    TokenResponse|error token = check getToken(oauthEndpointConfig);
    if (token is error) {
        return error("Failed to get a token", 'error = token);
    }

    string headerValue = string `Bearer ${token.accessToken}`;
    req.setHeader(headerName, headerValue);

    return;
}

