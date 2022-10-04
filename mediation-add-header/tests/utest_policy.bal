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
public function testInFlowSingleInstance() {
    http:Request req = new;
    http:Response|false|error|() result = addHeader_In({httpMethod: "get", resourcePath: "/greet"}, req, "x-foo", "FooIn");
    
    if result !is () {
        test:assertFail("Expected '()', found " + (typeof result).toString());
    }

    string[]|http:HeaderNotFoundError headers = req.getHeaders("x-foo");

    if headers is http:HeaderNotFoundError {
        test:assertFail("Header 'x-foo' not found in the request");
    }

    test:assertEquals(headers, ["FooIn"]);
}

@test:Config {}
public function testOutFlowSingleInstance() {
    http:Response res = new;
    http:Response|false|error|() result = addHeader_Out({httpMethod: "get", resourcePath: "/greet"}, new, res, "x-foo", "FooOut");
    assertResult(result, res.getHeaders("x-foo"), "FooOut");
}

@test:Config {}
public function testFaultFlowSingleInstance() {
    http:Response errRes = new;
    http:Response|false|error|() result = addHeader_Fault({httpMethod: "get", resourcePath: "/greet"}, new, (), errRes, error("Error"), "x-foo", "FooFault");
    assertResult(result, errRes.getHeaders("x-foo"), "FooFault");
}

@test:Config {}
public function testInFlowMultipleInstances() {
    http:Request req = new;
    http:Response|false|error|() result = addHeader_In({httpMethod: "get", resourcePath: "/greet"}, req, "x-foo", "FooIn1");
    assertResult(result, req.getHeaders("x-foo"), "FooIn1");

    result = addHeader_In({httpMethod: "get", resourcePath: "/greet"}, req, "x-bar", "BarIn");
    assertResult(result, req.getHeaders("x-bar"), "BarIn");
    
    result = addHeader_In({httpMethod: "get", resourcePath: "/greet"}, req, "x-foo", "FooIn2");
    assertResult(result, req.getHeaders("x-foo"), "FooIn1", "FooIn2");

    if !(result is ()) {
        test:assertFail("Expected '()', found " + (typeof result).toString());
    }

    string[]|http:HeaderNotFoundError headers = req.getHeaders("x-foo");

    if headers is http:HeaderNotFoundError {
        test:assertFail("Header 'x-foo' not found in the request");
    }

    test:assertEquals(headers, ["FooIn1", "FooIn2"]);

    headers = req.getHeaders("x-bar");

    if headers is http:HeaderNotFoundError {
        test:assertFail("Header 'x-bar' not found in the request");
    }

    test:assertEquals(headers, ["BarIn"]);
}

function assertResult(http:Response|false|error|() result, string[]|http:HeaderNotFoundError headers, string... expVal) {
    if !(result is ()) {
        test:assertFail("Expected '()', found " + (typeof result).toString());
    }

    if headers is http:HeaderNotFoundError {
        test:assertFail("Header 'x-foo' not found in the request");
    }

    test:assertEquals(headers, expVal);
}
