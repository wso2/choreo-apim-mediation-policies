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
public function tokenBasedRatelimit_In(mediation:Context ctx, http:Request req, int Max\ Prompt\ Token\ Count,
int Max\ Completion\ Token\ Count, int Max\ Total\ Token\ Count, string Time\ Unit) returns http:Response|false|error? {
  // This is an empty function to list this policy as an egress AI policy.
  // The actual logic is implemented in the Egress Gateway using BackendTrafficPolicy CR not utilizing ballerina mediation server.
  return;
}