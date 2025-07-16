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

@mediation:RequestFlow
public function azureContentSafetyContentModeration_In(mediation:Context ctx, http:Request req, string Guardrail\ Name, string Azure\ Content\ Safety\ Endpoint, 
string Azure\ Content\ Safety\ Key, int Hate\ Severity\ Level = -1, int Sexual\ Severity\ Level = -1, int Self\ Harm\ Severity\ Level = -1, 
int Violence\ Severity\ Level = -1, string JSON\ Path = "", boolean Passthrough\ On\ Error = false, boolean Show\ Guardrail\ Assessment = false) 
                                returns http:Response|false|error|() {
    return;
}

@mediation:ResponseFlow
public function azureContentSafetyContentModeration_Out(mediation:Context ctx, http:Request req, http:Response res, string Guardrail\ Name, string Azure\ Content\ Safety\ Endpoint, 
string Azure\ Content\ Safety\ Key, int Hate\ Severity\ Level = -1, int Sexual\ Severity\ Level = -1, int Self\ Harm\ Severity\ Level = -1, 
int Violence\ Severity\ Level = -1, string JSON\ Path = "", boolean Passthrough\ On\ Error = false, boolean Show\ Guardrail\ Assessment = false) 
                                returns http:Response|false|error|() {
    return;
}
