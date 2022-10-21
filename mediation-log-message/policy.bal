// Copyright (c) 2022 WSO2 LLC (http://www.wso2.org) All Rights Reserved.
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
import ballerina/log;
import ballerina/http;

@mediation:RequestFlow
public function logRequestMessage(mediation:Context ctx, http:Request req)
                                                                returns http:Response|false|error|() {
    string|http:ClientError payload = req.getTextPayload();

    if payload is http:ClientError {
        return error("Failed to log the request payload", payload);
    }

    log:printInfo(payload, direction = "request");
    return ();
}

@mediation:ResponseFlow
public function logResponseMessage(mediation:Context ctx, http:Request req, http:Response res)
                                                                returns http:Response|false|error|() {
    string|http:ClientError payload = res.getTextPayload();

    if payload is http:ClientError {
        return error("Failed to log the response payload", payload);
    }

    log:printInfo(payload, direction = "response");
    return ();
}

@mediation:FaultFlow
public function logFaultMessage(mediation:Context ctx, http:Request req, http:Response? resp,
                                    http:Response errFlowResp, error e)
                                                                returns http:Response|false|error|() {
    string|http:ClientError payload = errFlowResp.getTextPayload();

    if payload is http:ClientError {
        return error("Failed to log the fault-message payload", payload);
    }

    log:printInfo(payload, direction = "fault");
    return ();
}
