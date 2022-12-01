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
import choreo/mediation;
import ballerina/test;

@test:Config {}
public function testRequestFlowSingleInstance() {
    mediation:Context ctx = {httpMethod: "get", resourcePath: "/greet", "queryParams": <map<string[]>>{}};
    http:Response|false|error|() result = addQueryParam(ctx, new, "x", "y");
    assertResult(result, ctx["queryParams"], {x: ["y"]});
}

@test:Config {}
public function testRequestFlowMultipleInstance() {
    mediation:Context ctx = {httpMethod: "get", resourcePath: "/greet", "queryParams": <map<string[]>>{}};
    http:Response|false|error|() result = addQueryParam(ctx, new, "arr", "1");
    assertResult(result, ctx["queryParams"], {arr: ["1"]});

    result = addQueryParam(ctx, new, "arr", "2");
    assertResult(result, ctx["queryParams"], {arr: ["1", "2"]});
}

function assertResult(http:Response|false|error|() result, anydata qParamMap, map<string[]> expQParamMap) {
    if result !is () {
        test:assertFail("Expected '()', found " + (typeof result).toString());
    }

    test:assertEquals(qParamMap, expQParamMap);
}
