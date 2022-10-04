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
import ballerina/xmldata;
import ballerina/mime;
import ballerina/http;

@mediation:InFlow
public function xmlToJsonIn(mediation:Context ctx, http:Request req) returns http:Response|false|error|() {
    xml xmlPayload = check req.getXmlPayload();
    json jsonPayload = check xmldata:toJson(xmlPayload);
    req.setPayload(jsonPayload, mime:APPLICATION_JSON);
    return ();
}

@mediation:OutFlow
public function xmlToJsonOut(mediation:Context ctx, http:Request req, http:Response res) returns http:Response|false|error|() {
    xml xmlPayload = check res.getXmlPayload();
    json jsonPayload = check xmldata:toJson(xmlPayload);
    res.setPayload(jsonPayload, mime:APPLICATION_JSON);
    return ();
}
