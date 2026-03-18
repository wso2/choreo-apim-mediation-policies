// Copyright (c) 2026 WSO2 LLC (http://www.wso2.org) All Rights Reserved.
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

import choreo/mediation;
import ballerina/http;
import ballerina/url;
import ballerina/log;

import choreo/mediation.authenticator_mtls.'com.wso2.choreo.am.mediation.certificates as certificates;

const CERTIFICATE_HEADER = "x-client-cert-x509";
json AUTHENTICATION_FAILURE_MESSAGE = {
    "error_message": "Invalid Credentials",
    "code": "900901",
    "error_description": "Make sure you have provided the correct security credentials."
};

@mediation:RequestFlow
public function addHeader_In(mediation:Context ctx, http:Request req, string Certificate\ Content, boolean Optional = false)
                                                                returns http:Response|false|error|() {
    log:printInfo("Starting mTLS authentication validation");

    string savedCertString = check url:decode(Certificate\ Content, "UTF-8");
    string|http:HeaderNotFoundError incomingCertString = req.getHeader(CERTIFICATE_HEADER);
  
    if (incomingCertString is http:HeaderNotFoundError) {
        log:printDebug("MTLS Header not found");
        if (Optional) {
            log:printDebug("MTLS Header is optional, returning without error.");
            return ();
        }
        return generateResponse(AUTHENTICATION_FAILURE_MESSAGE, http:STATUS_UNAUTHORIZED);
    } else {
        string|error clientCertString = url:decode(incomingCertString, "UTF-8");
        if (clientCertString is error) {
            log:printError("Invalid URL-encoded certificate in x-client-cert-x509 header");
            return generateResponse(AUTHENTICATION_FAILURE_MESSAGE, http:STATUS_UNAUTHORIZED);
        }
        certificates:ValidationResponse resp = certificates:CertificateValidator_verifyCertificates(savedCertString, clientCertString);
        if (resp.isVerify()) {
            log:printInfo("mTLS authentication successful – client certificate validated");
            return ();
        } else {
            log:printDebug("Client certificate does not match the saved certificate. " + resp.getMessage());
            return generateResponse(AUTHENTICATION_FAILURE_MESSAGE, http:STATUS_UNAUTHORIZED);
        }
    }
}

function generateResponse(json payload, int statusCode) returns http:Response {
    http:Response response = new ();
    response.setJsonPayload(payload);
    response.statusCode = statusCode;
    return response;
}


