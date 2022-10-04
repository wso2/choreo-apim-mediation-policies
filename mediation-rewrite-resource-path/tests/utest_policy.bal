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
public function testInFlowSingleInstance() {
    mediation:Context ctx = {httpMethod: "get", resourcePath: "/greet"};
    http:Response|false|error|() result = rewrite(ctx, new, "/new-greet");
    assertResult(result, ctx.resourcePath, "/new-greet");
}

@test:Config {}
public function testInFlowMultipleInstance() {
    mediation:Context ctx = {httpMethod: "get", resourcePath: "/greet"};
    http:Response|false|error|() result = rewrite(ctx, new, "/foo-greet");
    assertResult(result, ctx.resourcePath, "/foo-greet");

    result = rewrite(ctx, new, "bar-greet");
    assertResult(result, ctx.resourcePath, "/bar-greet");
}

function assertResult(http:Response|false|error|() result, string resourcePath, string expResourcePath) {
    if !(result is ()) {
        test:assertFail("Expected '()', found " + (typeof result).toString());
    }

    test:assertEquals(resourcePath, expResourcePath);
}
