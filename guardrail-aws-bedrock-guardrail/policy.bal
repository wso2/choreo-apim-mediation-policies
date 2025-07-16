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
public function awsBedrockGuardrail_In(mediation:Context ctx, http:Request req, string Guardrail\ Name, string AWS\ Guardrail\ ID, 
string AWS\ Guardrail\ Version, string AWS\ Guardrail\ Region, string AWS\ Access\ Key\ ID, string AWS\ Secret\ Access\ Key, 
string AWS\ Session\ Token = "", string AWS\ Role\ ARN = "", string AWS\ Role\ Region = "", string AWS\ Role\ External\ ID = "", string JSON\ Path = "", 
boolean Redact\ PII = false, boolean Passthrough\ On\ Error = false, boolean Show\ Guardrail\ Assessment = false) 
                                returns http:Response|false|error|() {
    return;
}

@mediation:ResponseFlow
public function awsBedrockGuardrail_Out(mediation:Context ctx, http:Request req, http:Response res, string Guardrail\ Name, string AWS\ Guardrail\ ID, 
string AWS\ Guardrail\ Version, string AWS\ Guardrail\ Region, string AWS\ Access\ Key\ ID, string AWS\ Secret\ Access\ Key, string AWS\ Session\ Token = "", 
string AWS\ Role\ ARN = "", string AWS\ Role\ Region = "", string AWS\ Role\ External\ ID = "", string JSON\ Path = "", boolean Redact\ PII = false, 
boolean Passthrough\ On\ Error = false, boolean Show\ Guardrail\ Assessment = false) 
                                returns http:Response|false|error|() {
    return;
}

