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
    mediation:Context ctx = createContext("get", "/greet");
    ctx.addQueryParam("x", "y");
    http:Response|false|error|() result = removeQueryParam(ctx, new, "x");
    assertResult(result, ctx.queryParams(), {});
}

@test:Config {}
public function testRequestFlowMultipleInstance() {
    mediation:Context ctx = createContext("get", "/greet");
    ctx.addQueryParam("arr", "1");
    ctx.addQueryParam("arr", "2");
    ctx.addQueryParam("x", "y");
    http:Response|false|error|() result = removeQueryParam(ctx, new, "arr");
    assertResult(result, ctx.queryParams(), {x: ["y"]});

    result = removeQueryParam(ctx, new, "x");
    assertResult(result, ctx.queryParams(), {});
}

function assertResult(http:Response|false|error|() result, anydata qParamMap, map<string[]> expQParamMap) {
    if result !is () {
        test:assertFail("Expected '()', found " + (typeof result).toString());
    }

    test:assertEquals(qParamMap, expQParamMap);
}

function createContext(string httpMethod, string resPath) returns mediation:Context {
    mediation:ResourcePath originalPath = checkpanic mediation:createImmutableResourcePath(resPath);
    mediation:Context originalCtx =
                mediation:createImmutableMediationContext(httpMethod, originalPath.pathSegments(), {}, {});
    mediation:ResourcePath mutableResPath = checkpanic mediation:createMutableResourcePath(resPath);
    return mediation:createMutableMediationContext(originalCtx, mutableResPath.pathSegments(), {}, {});
}
