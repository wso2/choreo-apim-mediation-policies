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
import ballerina/regex;

function buildRequestHeadersMap(http:Request req, string excluded) returns map<string|string[]> {
    map<string|string[]> headers = {};
    map<()> excludedHeaders = getHeaderNames(excluded); // using map<()> to in lieu of a set

    foreach var name in req.getHeaderNames() {
        string[] values = checkpanic req.getHeaders(name);

        if excludedHeaders.hasKey(name.toLowerAscii()) {
            continue;
        }

        if name.equalsIgnoreCaseAscii(http:AUTHORIZATION) {
            headers[name] = "***";
            continue;
        }

        if values.length() == 1 {
            headers[name] = values[0];
        } else {
            headers[name] = values;
        }
    }

    return headers;
}

function buildResponseHeadersMap(http:Response res, string excluded) returns map<string|string[]> {
    map<string|string[]> headers = {};
    map<()> excludedHeaders = getHeaderNames(excluded); // using map<()> to in lieu of a set

    foreach var name in res.getHeaderNames() {
        string[] values = checkpanic res.getHeaders(name);

        if excludedHeaders.hasKey(name.toLowerAscii()) {
            continue;
        }

        if values.length() == 1 {
            headers[name] = values[0];
        } else {
            headers[name] = values;
        }
    }

    return headers;
}

function getHeaderNames(string excluded) returns map<()> {
    string[] names = regex:split(excluded, ",");
    map<()> excludedHeaders = {};

    foreach var name in names {
        excludedHeaders[name.trim().toLowerAscii()] = ();
    }

    return excludedHeaders;
}
