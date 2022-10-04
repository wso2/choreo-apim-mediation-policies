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

xml originalPayload = xml `<greeting><name>John Doe</name><message>Hello World!</message></greeting>`;
json expPayload = {"greeting": {"name": "John Doe", "message": "Hello World!"}};

@test:Config {}
public function testInFlowSingleInstance() {
    http:Request req = new;
    req.setXmlPayload(originalPayload);
    http:Response|false|error|() result = xmlToJsonIn({httpMethod: "get", resourcePath: "/greet"}, req);
    assertResult(result, req.getJsonPayload(), expPayload);
}

@test:Config {}
public function testOutFlowSingleInstance() {
    http:Response res = new;
    res.setXmlPayload(originalPayload);
    http:Response|false|error|() result = xmlToJsonOut({httpMethod: "get", resourcePath: "/greet"}, new, res);
    assertResult(result, res.getJsonPayload(), expPayload);
}

function assertResult(http:Response|false|error|() result, json|http:ClientError payload, json expVal) {
    if !(result is ()) {
        test:assertFail("Expected '()', found " + (typeof result).toString());
    }

    if payload is http:ClientError {
        test:assertFail("Failed to retrieve a valid JSON payload");
    }

    test:assertEquals(payload, expVal);
}
