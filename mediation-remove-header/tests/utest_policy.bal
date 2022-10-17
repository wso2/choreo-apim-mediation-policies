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

@test:Config {}
public function testRequestFlowSingleInstance() {
    http:Request req = new;
    req.addHeader("x-foo", "request-flow");
    http:Response|false|error|() result = removeHeaderRequestFlow({httpMethod: "get", resourcePath: "/greet"}, req, "x-foo");
    assertResult(result, req.getHeaders("x-foo"));
}

@test:Config {}
public function testResponseFlowSingleInstance() {
    http:Response res = new;
    res.addHeader("x-foo", "response-flow");
    http:Response|false|error|() result = removeHeaderResponseFlow({httpMethod: "get", resourcePath: "/greet"}, new, res, "x-foo");
    assertResult(result, res.getHeaders("x-foo"));
}

@test:Config {}
public function testFaultFlowSingleInstance() {
    http:Response errRes = new;
    http:Response|false|error|() result = removeHeaderFaultFlow({httpMethod: "get", resourcePath: "/greet"}, new, (), errRes, error("Error"), "x-foo");
    assertResult(result, errRes.getHeaders("x-foo"));
}

@test:Config {}
public function testRequestFlowMultipleInstances() {
    http:Request req = new;
    req.addHeader("x-foo", "request-h1");
    req.addHeader("x-foo", "request-h2");
    req.addHeader("x-bar", "request-h3");
    
    http:Response|false|error|() result = removeHeaderRequestFlow({httpMethod: "get", resourcePath: "/greet"}, req, "x-foo");
    assertResult(result, req.getHeaders("x-foo"));

    result = removeHeaderRequestFlow({httpMethod: "get", resourcePath: "/greet"}, req, "x-bar");
    assertResult(result, req.getHeaders("x-bar"));

    result = removeHeaderRequestFlow({httpMethod: "get", resourcePath: "/greet"}, req, "x-foo");
    assertResult(result, req.getHeaders("x-foo"));
}

function assertResult(http:Response|false|error|() result, string[]|http:HeaderNotFoundError headers) {
    if result !is () {
        test:assertFail("Expected '()', found " + (typeof result).toString());
    }

    if headers is string[] {
        test:assertFail("Header 'x-foo' is present in the request");
    }
}
