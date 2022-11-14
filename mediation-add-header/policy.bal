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
import ballerina/http;

@mediation:RequestFlow
public function addHeader_In(mediation:Context ctx, http:Request req, string Header\ Name, string Header\ Value)
                                                                returns http:Response|false|error|() {
    req.addHeader(Header\ Name, Header\ Value);
    return ();
}

@mediation:ResponseFlow
public function addHeader_Out(mediation:Context ctx, http:Request req, http:Response res, string Header\ Name, 
                                string Header\ Value) returns http:Response|false|error|() {
    res.addHeader(Header\ Name, Header\ Value);
    return ();
}

@mediation:FaultFlow
public function addHeader_Fault(mediation:Context ctx, http:Request req, http:Response? resp, 
                                    http:Response errFlowResp, error e, string Header\ Name, 
                                        string Header\ Value) returns http:Response|false|error|() {
    errFlowResp.addHeader(Header\ Name, Header\ Value);
    return ();
}
