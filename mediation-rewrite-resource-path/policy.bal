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
import ballerina/regex;

const PATH_PARAM_PATTERN = "\\{[^\\{\\}\\n\\r\\t\\ ]+\\}";

@mediation:RequestFlow
public function rewrite(mediation:Context ctx, http:Request req, string newPath, boolean keepQueryParams)
                                                                returns http:Response|false|error|() {
    string modifiedPath = check mapPathParams(<map<anydata>>ctx["pathParams"], newPath);

    if keepQueryParams {
        modifiedPath += buildQueryParams(req);
    }

    if modifiedPath[0] == "/" {
        ctx.resourcePath = modifiedPath;
    } else {
        ctx.resourcePath = string `/${modifiedPath}`;
    }

    return ();
}

function mapPathParams(map<anydata> proxyPathParams, string newPath) returns string|error {
    regex:Match[] epPathParams = findPathParamNames(newPath);
    string modifiedPath = newPath;

    foreach var item in epPathParams {
        string name = getName(item.matched);

        if !proxyPathParams.hasKey(name) {
            return error("Failed to re-write resource path", message = string `Invalid path param: ${name}`);
        }

        anydata pathParamVal = proxyPathParams[name];
        modifiedPath = regex:replace(modifiedPath, PATH_PARAM_PATTERN, pathParamVal.toString());
    }

    return modifiedPath;
}

function getName(string pathParam) returns string => pathParam.substring(1, pathParam.length() - 1);

function findPathParamNames(string s) returns regex:Match[] => regex:searchAll(s, PATH_PARAM_PATTERN);

function buildQueryParams(http:Request req) returns string {
    map<string[]> params = req.getQueryParams();

    if (params.length() == 0) {
        return "";
    }

    string qParamStr = "?";

    foreach [string, string[]] [name, val] in params.entries() {
        foreach string item in val {
            qParamStr += string `${name}=${item}&`;
        }
    }

    return qParamStr.substring(0, qParamStr.length() - 1);
}
