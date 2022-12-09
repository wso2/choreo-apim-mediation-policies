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
import choreo/mediation;

@test:Config {}
public function testRequestFlowSingleInstance() {
    http:Request req = new;
    req.setHeader("x-foo", "FooOriginal");
    http:Response|false|error|() result = setHeaderInRequest(createContext("get", "/greet"), req, "x-foo", "FooNew");
    
    if result !is () {
        test:assertFail("Expected '()', found " + (typeof result).toString());
    }

    string[]|http:HeaderNotFoundError headers = req.getHeaders("x-foo");

    if headers is http:HeaderNotFoundError {
        test:assertFail("Header 'x-foo' not found in the request");
    }

    test:assertEquals(headers, ["FooNew"]);
}

@test:Config {}
public function testResponseFlowSingleInstance() {
    http:Response res = new;
    res.setHeader("x-foo", "FooOriginal");
    http:Response|false|error|() result = setHeaderInResponse(createContext("get", "/greet"), new, res, "x-foo", "FooNew");
    assertResult(result, res.getHeaders("x-foo"), "FooNew");
}

@test:Config {}
public function testFaultFlowSingleInstance() {
    http:Response errRes = new;
    errRes.setHeader("x-foo", "FooOriginal");
    http:Response|false|error|() result = setHeaderInFaultResponse(createContext("get", "/greet"), new, (), errRes, error("Error"), "x-foo", "FooNew");
    assertResult(result, errRes.getHeaders("x-foo"), "FooNew");
}

@test:Config {}
public function testRequestFlowMultipleInstances() {
    http:Request req = new;
    http:Response|false|error|() result = setHeaderInRequest(createContext("get", "/greet"), req, "x-foo", "FooIn1");
    assertResult(result, req.getHeaders("x-foo"), "FooIn1");

    result = setHeaderInRequest(createContext("get", "/greet"), req, "x-bar", "BarIn");
    assertResult(result, req.getHeaders("x-bar"), "BarIn");
    
    result = setHeaderInRequest(createContext("get", "/greet"), req, "x-foo", "FooIn2");
    assertResult(result, req.getHeaders("x-foo"), "FooIn2");
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

function createContext(string httpMethod, string resPath) returns mediation:Context {
    mediation:ResourcePath originalPath = checkpanic mediation:createImmutableResourcePath(resPath);
    mediation:Context originalCtx =
                mediation:createImmutableMediationContext(httpMethod, originalPath.pathSegments(), {}, {});
    mediation:ResourcePath mutableResPath = checkpanic mediation:createMutableResourcePath(resPath);
    return mediation:createMutableMediationContext(originalCtx, mutableResPath.pathSegments(), {}, {});
}
