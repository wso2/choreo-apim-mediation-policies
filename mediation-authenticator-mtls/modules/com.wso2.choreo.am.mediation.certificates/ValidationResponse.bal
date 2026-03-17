// Copyright (c) 2026 WSO2 LLC (http://www.wso2.org) All Rights Reserved.
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

import ballerina/jballerina.java;
import choreo/mediation.authenticator_mtls.'java.lang as javalang;

# Ballerina class mapping for the Java `com.wso2.choreo.am.mediation.certificates.ValidationResponse` class.
@java:Binding {'class: "com.wso2.choreo.am.mediation.certificates.ValidationResponse"}
public distinct class ValidationResponse {

    *java:JObject;
    *javalang:Object;

    # The `handle` field that stores the reference to the `com.wso2.choreo.am.mediation.certificates.ValidationResponse` object.
    public handle jObj;

    # The init function of the Ballerina class mapping the `com.wso2.choreo.am.mediation.certificates.ValidationResponse` Java class.
    #
    # + obj - The `handle` value containing the Java reference of the object.
    public function init(handle obj) {
        self.jObj = obj;
    }

    # The function to retrieve the string representation of the Ballerina class mapping the `com.wso2.choreo.am.mediation.certificates.ValidationResponse` Java class.
    #
    # + return - The `string` form of the Java object instance.
    public function toString() returns string {
        return java:toString(self.jObj) ?: "";
    }
    # The function that maps to the `equals` method of `com.wso2.choreo.am.mediation.certificates.ValidationResponse`.
    #
    # + arg0 - The `javalang:Object` value required to map with the Java method parameter.
    # + return - The `boolean` value returning from the Java mapping.
    public function 'equals(javalang:Object arg0) returns boolean {
        return com_wso2_choreo_am_mediation_certificates_ValidationResponse_equals(self.jObj, arg0.jObj);
    }

    # The function that maps to the `getClass` method of `com.wso2.choreo.am.mediation.certificates.ValidationResponse`.
    #
    # + return - The `javalang:Class` value returning from the Java mapping.
    public function getClass() returns javalang:Class {
        handle externalObj = com_wso2_choreo_am_mediation_certificates_ValidationResponse_getClass(self.jObj);
        javalang:Class newObj = new (externalObj);
        return newObj;
    }

    # The function that maps to the `getMessage` method of `com.wso2.choreo.am.mediation.certificates.ValidationResponse`.
    #
    # + return - The `string` value returning from the Java mapping.
    public function getMessage() returns string {
        return java:toString(com_wso2_choreo_am_mediation_certificates_ValidationResponse_getMessage(self.jObj)) ?: "";
    }

    # The function that maps to the `hashCode` method of `com.wso2.choreo.am.mediation.certificates.ValidationResponse`.
    #
    # + return - The `int` value returning from the Java mapping.
    public function hashCode() returns int {
        return com_wso2_choreo_am_mediation_certificates_ValidationResponse_hashCode(self.jObj);
    }

    # The function that maps to the `isVerify` method of `com.wso2.choreo.am.mediation.certificates.ValidationResponse`.
    #
    # + return - The `boolean` value returning from the Java mapping.
    public function isVerify() returns boolean {
        return com_wso2_choreo_am_mediation_certificates_ValidationResponse_isVerify(self.jObj);
    }

    # The function that maps to the `notify` method of `com.wso2.choreo.am.mediation.certificates.ValidationResponse`.
    public function notify() {
        com_wso2_choreo_am_mediation_certificates_ValidationResponse_notify(self.jObj);
    }

    # The function that maps to the `notifyAll` method of `com.wso2.choreo.am.mediation.certificates.ValidationResponse`.
    public function notifyAll() {
        com_wso2_choreo_am_mediation_certificates_ValidationResponse_notifyAll(self.jObj);
    }

    # The function that maps to the `setMessage` method of `com.wso2.choreo.am.mediation.certificates.ValidationResponse`.
    #
    # + arg0 - The `string` value required to map with the Java method parameter.
    public function setMessage(string arg0) {
        com_wso2_choreo_am_mediation_certificates_ValidationResponse_setMessage(self.jObj, java:fromString(arg0));
    }

    # The function that maps to the `setVerify` method of `com.wso2.choreo.am.mediation.certificates.ValidationResponse`.
    #
    # + arg0 - The `boolean` value required to map with the Java method parameter.
    public function setVerify(boolean arg0) {
        com_wso2_choreo_am_mediation_certificates_ValidationResponse_setVerify(self.jObj, arg0);
    }

    # The function that maps to the `wait` method of `com.wso2.choreo.am.mediation.certificates.ValidationResponse`.
    #
    # + return - The `javalang:InterruptedException` value returning from the Java mapping.
    public function 'wait() returns javalang:InterruptedException? {
        error|() externalObj = com_wso2_choreo_am_mediation_certificates_ValidationResponse_wait(self.jObj);
        if (externalObj is error) {
            javalang:InterruptedException e = error javalang:InterruptedException(javalang:INTERRUPTEDEXCEPTION, externalObj, message = externalObj.message());
            return e;
        }
    }

    # The function that maps to the `wait` method of `com.wso2.choreo.am.mediation.certificates.ValidationResponse`.
    #
    # + arg0 - The `int` value required to map with the Java method parameter.
    # + return - The `javalang:InterruptedException` value returning from the Java mapping.
    public function wait2(int arg0) returns javalang:InterruptedException? {
        error|() externalObj = com_wso2_choreo_am_mediation_certificates_ValidationResponse_wait2(self.jObj, arg0);
        if (externalObj is error) {
            javalang:InterruptedException e = error javalang:InterruptedException(javalang:INTERRUPTEDEXCEPTION, externalObj, message = externalObj.message());
            return e;
        }
    }

    # The function that maps to the `wait` method of `com.wso2.choreo.am.mediation.certificates.ValidationResponse`.
    #
    # + arg0 - The `int` value required to map with the Java method parameter.
    # + arg1 - The `int` value required to map with the Java method parameter.
    # + return - The `javalang:InterruptedException` value returning from the Java mapping.
    public function wait3(int arg0, int arg1) returns javalang:InterruptedException? {
        error|() externalObj = com_wso2_choreo_am_mediation_certificates_ValidationResponse_wait3(self.jObj, arg0, arg1);
        if (externalObj is error) {
            javalang:InterruptedException e = error javalang:InterruptedException(javalang:INTERRUPTEDEXCEPTION, externalObj, message = externalObj.message());
            return e;
        }
    }

}

# The constructor function to generate an object of `com.wso2.choreo.am.mediation.certificates.ValidationResponse`.
#
# + return - The new `ValidationResponse` class generated.
public function newValidationResponse1() returns ValidationResponse {
    handle externalObj = com_wso2_choreo_am_mediation_certificates_ValidationResponse_newValidationResponse1();
    ValidationResponse newObj = new (externalObj);
    return newObj;
}

function com_wso2_choreo_am_mediation_certificates_ValidationResponse_equals(handle receiver, handle arg0) returns boolean = @java:Method {
    name: "equals",
    'class: "com.wso2.choreo.am.mediation.certificates.ValidationResponse",
    paramTypes: ["java.lang.Object"]
} external;

function com_wso2_choreo_am_mediation_certificates_ValidationResponse_getClass(handle receiver) returns handle = @java:Method {
    name: "getClass",
    'class: "com.wso2.choreo.am.mediation.certificates.ValidationResponse",
    paramTypes: []
} external;

function com_wso2_choreo_am_mediation_certificates_ValidationResponse_getMessage(handle receiver) returns handle = @java:Method {
    name: "getMessage",
    'class: "com.wso2.choreo.am.mediation.certificates.ValidationResponse",
    paramTypes: []
} external;

function com_wso2_choreo_am_mediation_certificates_ValidationResponse_hashCode(handle receiver) returns int = @java:Method {
    name: "hashCode",
    'class: "com.wso2.choreo.am.mediation.certificates.ValidationResponse",
    paramTypes: []
} external;

function com_wso2_choreo_am_mediation_certificates_ValidationResponse_isVerify(handle receiver) returns boolean = @java:Method {
    name: "isVerify",
    'class: "com.wso2.choreo.am.mediation.certificates.ValidationResponse",
    paramTypes: []
} external;

function com_wso2_choreo_am_mediation_certificates_ValidationResponse_notify(handle receiver) = @java:Method {
    name: "notify",
    'class: "com.wso2.choreo.am.mediation.certificates.ValidationResponse",
    paramTypes: []
} external;

function com_wso2_choreo_am_mediation_certificates_ValidationResponse_notifyAll(handle receiver) = @java:Method {
    name: "notifyAll",
    'class: "com.wso2.choreo.am.mediation.certificates.ValidationResponse",
    paramTypes: []
} external;

function com_wso2_choreo_am_mediation_certificates_ValidationResponse_setMessage(handle receiver, handle arg0) = @java:Method {
    name: "setMessage",
    'class: "com.wso2.choreo.am.mediation.certificates.ValidationResponse",
    paramTypes: ["java.lang.String"]
} external;

function com_wso2_choreo_am_mediation_certificates_ValidationResponse_setVerify(handle receiver, boolean arg0) = @java:Method {
    name: "setVerify",
    'class: "com.wso2.choreo.am.mediation.certificates.ValidationResponse",
    paramTypes: ["boolean"]
} external;

function com_wso2_choreo_am_mediation_certificates_ValidationResponse_wait(handle receiver) returns error? = @java:Method {
    name: "wait",
    'class: "com.wso2.choreo.am.mediation.certificates.ValidationResponse",
    paramTypes: []
} external;

function com_wso2_choreo_am_mediation_certificates_ValidationResponse_wait2(handle receiver, int arg0) returns error? = @java:Method {
    name: "wait",
    'class: "com.wso2.choreo.am.mediation.certificates.ValidationResponse",
    paramTypes: ["long"]
} external;

function com_wso2_choreo_am_mediation_certificates_ValidationResponse_wait3(handle receiver, int arg0, int arg1) returns error? = @java:Method {
    name: "wait",
    'class: "com.wso2.choreo.am.mediation.certificates.ValidationResponse",
    paramTypes: ["long", "int"]
} external;

function com_wso2_choreo_am_mediation_certificates_ValidationResponse_newValidationResponse1() returns handle = @java:Constructor {
    'class: "com.wso2.choreo.am.mediation.certificates.ValidationResponse",
    paramTypes: []
} external;

