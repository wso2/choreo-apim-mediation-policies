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

import ballerina/http;
import ballerina/test;

json originalPayload = {"name":"John Doe", "greeting":"Hello World!"};
xml expPayload = xml `<root><name>John Doe</name><greeting>Hello World!</greeting></root>`;

@test:Config {}
public function testInFlowSingleInstance() {
    http:Request req = new;
    req.setJsonPayload(originalPayload);
    http:Response|false|error|() result = jsonToXmlIn({httpMethod: "get", resourcePath: "/greet"}, req);
    assertResult(result, req.getXmlPayload(), expPayload);
}

@test:Config {}
public function testOutFlowSingleInstance() {
    http:Response res = new;
    res.setJsonPayload(originalPayload);
    http:Response|false|error|() result = jsonToXmlOut({httpMethod: "get", resourcePath: "/greet"}, new, res);
    assertResult(result, res.getXmlPayload(), expPayload);
}

function assertResult(http:Response|false|error|() result, xml|http:ClientError payload, xml expVal) {
    if !(result is ()) {
        test:assertFail("Expected '()', found " + (typeof result).toString());
    }

    if payload is http:ClientError {
        test:assertFail("Failed to retrieve a valid XML payload");
    }

    test:assertEquals(payload, expVal);
}
