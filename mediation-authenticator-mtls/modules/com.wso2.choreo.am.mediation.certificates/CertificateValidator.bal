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
import ballerina/log;
import choreo/mediation.authenticator_mtls.'java.lang as javalang;
import choreo/mediation.authenticator_mtls.'java.security.cert as javasecuritycert;

# Ballerina class mapping for the Java `com.wso2.choreo.am.mediation.certificates.CertificateValidator` class.
@java:Binding {'class: "com.wso2.choreo.am.mediation.certificates.CertificateValidator"}
public distinct class CertificateValidator {

    *java:JObject;
    *javalang:Object;

    # The `handle` field that stores the reference to the `com.wso2.choreo.am.mediation.certificates.CertificateValidator` object.
    public handle jObj;

    # The init function of the Ballerina class mapping the `com.wso2.choreo.am.mediation.certificates.CertificateValidator` Java class.
    #
    # + obj - The `handle` value containing the Java reference of the object.
    public function init(handle obj) {
        self.jObj = obj;
    }

    # The function to retrieve the string representation of the Ballerina class mapping the `com.wso2.choreo.am.mediation.certificates.CertificateValidator` Java class.
    #
    # + return - The `string` form of the Java object instance.
    public function toString() returns string {
        return java:toString(self.jObj) ?: "";
    }
    # The function that maps to the `equals` method of `com.wso2.choreo.am.mediation.certificates.CertificateValidator`.
    #
    # + arg0 - The `javalang:Object` value required to map with the Java method parameter.
    # + return - The `boolean` value returning from the Java mapping.
    public function 'equals(javalang:Object arg0) returns boolean {
        return com_wso2_choreo_am_mediation_certificates_CertificateValidator_equals(self.jObj, arg0.jObj);
    }

    # The function that maps to the `getClass` method of `com.wso2.choreo.am.mediation.certificates.CertificateValidator`.
    #
    # + return - The `javalang:Class` value returning from the Java mapping.
    public function getClass() returns javalang:Class {
        handle externalObj = com_wso2_choreo_am_mediation_certificates_CertificateValidator_getClass(self.jObj);
        javalang:Class newObj = new (externalObj);
        return newObj;
    }

    # The function that maps to the `hashCode` method of `com.wso2.choreo.am.mediation.certificates.CertificateValidator`.
    #
    # + return - The `int` value returning from the Java mapping.
    public function hashCode() returns int {
        return com_wso2_choreo_am_mediation_certificates_CertificateValidator_hashCode(self.jObj);
    }

    # The function that maps to the `notify` method of `com.wso2.choreo.am.mediation.certificates.CertificateValidator`.
    public function notify() {
        com_wso2_choreo_am_mediation_certificates_CertificateValidator_notify(self.jObj);
    }

    # The function that maps to the `notifyAll` method of `com.wso2.choreo.am.mediation.certificates.CertificateValidator`.
    public function notifyAll() {
        com_wso2_choreo_am_mediation_certificates_CertificateValidator_notifyAll(self.jObj);
    }

    # The function that maps to the `wait` method of `com.wso2.choreo.am.mediation.certificates.CertificateValidator`.
    #
    # + return - The `javalang:InterruptedException` value returning from the Java mapping.
    public function 'wait() returns javalang:InterruptedException? {
        error|() externalObj = com_wso2_choreo_am_mediation_certificates_CertificateValidator_wait(self.jObj);
        if (externalObj is error) {
            javalang:InterruptedException e = error javalang:InterruptedException(javalang:INTERRUPTEDEXCEPTION, externalObj, message = externalObj.message());
            return e;
        }
    }

    # The function that maps to the `wait` method of `com.wso2.choreo.am.mediation.certificates.CertificateValidator`.
    #
    # + arg0 - The `int` value required to map with the Java method parameter.
    # + return - The `javalang:InterruptedException` value returning from the Java mapping.
    public function wait2(int arg0) returns javalang:InterruptedException? {
        error|() externalObj = com_wso2_choreo_am_mediation_certificates_CertificateValidator_wait2(self.jObj, arg0);
        if (externalObj is error) {
            javalang:InterruptedException e = error javalang:InterruptedException(javalang:INTERRUPTEDEXCEPTION, externalObj, message = externalObj.message());
            return e;
        }
    }

    # The function that maps to the `wait` method of `com.wso2.choreo.am.mediation.certificates.CertificateValidator`.
    #
    # + arg0 - The `int` value required to map with the Java method parameter.
    # + arg1 - The `int` value required to map with the Java method parameter.
    # + return - The `javalang:InterruptedException` value returning from the Java mapping.
    public function wait3(int arg0, int arg1) returns javalang:InterruptedException? {
        error|() externalObj = com_wso2_choreo_am_mediation_certificates_CertificateValidator_wait3(self.jObj, arg0, arg1);
        if (externalObj is error) {
            javalang:InterruptedException e = error javalang:InterruptedException(javalang:INTERRUPTEDEXCEPTION, externalObj, message = externalObj.message());
            return e;
        }
    }

}

# The constructor function to generate an object of `com.wso2.choreo.am.mediation.certificates.CertificateValidator`.
#
# + return - The new `CertificateValidator` class generated.
public function newCertificateValidator1() returns CertificateValidator {
    handle externalObj = com_wso2_choreo_am_mediation_certificates_CertificateValidator_newCertificateValidator1();
    CertificateValidator newObj = new (externalObj);
    return newObj;
}

# The function that maps to the `getCertificate` method of `com.wso2.choreo.am.mediation.certificates.CertificateValidator`.
#
# + arg0 - The `string` value required to map with the Java method parameter.
# + return - The `javasecuritycert:X509Certificate` or the `javasecuritycert:CertificateException` value returning from the Java mapping.
public function CertificateValidator_getCertificate(string arg0) returns javasecuritycert:X509Certificate|javasecuritycert:CertificateException {
    handle|error externalObj = com_wso2_choreo_am_mediation_certificates_CertificateValidator_getCertificate(java:fromString(arg0));
    if (externalObj is error) {
        javasecuritycert:CertificateException e = error javasecuritycert:CertificateException(javasecuritycert:CERTIFICATEEXCEPTION, externalObj, message = externalObj.message());
        return e;
    } else {
        javasecuritycert:X509Certificate newObj = new (externalObj);
        return newObj;
    }
}

# The function that maps to the `verifyCertificates` method of `com.wso2.choreo.am.mediation.certificates.CertificateValidator`.
#
# + arg0 - The `string` value required to map with the Java method parameter.
# + arg1 - The `string` value required to map with the Java method parameter.
# + return - The `ValidationResponse` value returning from the Java mapping.
public function CertificateValidator_verifyCertificates(string arg0, string arg1) returns ValidationResponse {
    log:printInfo("Verifying certificates");
    handle externalObj = com_wso2_choreo_am_mediation_certificates_CertificateValidator_verifyCertificates(java:fromString(arg0), java:fromString(arg1));
    ValidationResponse newObj = new (externalObj);
    log:printDebug("Certificate verification completed");
    return newObj;
}

function com_wso2_choreo_am_mediation_certificates_CertificateValidator_equals(handle receiver, handle arg0) returns boolean = @java:Method {
    name: "equals",
    'class: "com.wso2.choreo.am.mediation.certificates.CertificateValidator",
    paramTypes: ["java.lang.Object"]
} external;

function com_wso2_choreo_am_mediation_certificates_CertificateValidator_getCertificate(handle arg0) returns handle|error = @java:Method {
    name: "getCertificate",
    'class: "com.wso2.choreo.am.mediation.certificates.CertificateValidator",
    paramTypes: ["java.lang.String"]
} external;

function com_wso2_choreo_am_mediation_certificates_CertificateValidator_getClass(handle receiver) returns handle = @java:Method {
    name: "getClass",
    'class: "com.wso2.choreo.am.mediation.certificates.CertificateValidator",
    paramTypes: []
} external;

function com_wso2_choreo_am_mediation_certificates_CertificateValidator_hashCode(handle receiver) returns int = @java:Method {
    name: "hashCode",
    'class: "com.wso2.choreo.am.mediation.certificates.CertificateValidator",
    paramTypes: []
} external;

function com_wso2_choreo_am_mediation_certificates_CertificateValidator_notify(handle receiver) = @java:Method {
    name: "notify",
    'class: "com.wso2.choreo.am.mediation.certificates.CertificateValidator",
    paramTypes: []
} external;

function com_wso2_choreo_am_mediation_certificates_CertificateValidator_notifyAll(handle receiver) = @java:Method {
    name: "notifyAll",
    'class: "com.wso2.choreo.am.mediation.certificates.CertificateValidator",
    paramTypes: []
} external;

function com_wso2_choreo_am_mediation_certificates_CertificateValidator_verifyCertificates(handle arg0, handle arg1) returns handle = @java:Method {
    name: "verifyCertificates",
    'class: "com.wso2.choreo.am.mediation.certificates.CertificateValidator",
    paramTypes: ["java.lang.String", "java.lang.String"]
} external;

function com_wso2_choreo_am_mediation_certificates_CertificateValidator_wait(handle receiver) returns error? = @java:Method {
    name: "wait",
    'class: "com.wso2.choreo.am.mediation.certificates.CertificateValidator",
    paramTypes: []
} external;

function com_wso2_choreo_am_mediation_certificates_CertificateValidator_wait2(handle receiver, int arg0) returns error? = @java:Method {
    name: "wait",
    'class: "com.wso2.choreo.am.mediation.certificates.CertificateValidator",
    paramTypes: ["long"]
} external;

function com_wso2_choreo_am_mediation_certificates_CertificateValidator_wait3(handle receiver, int arg0, int arg1) returns error? = @java:Method {
    name: "wait",
    'class: "com.wso2.choreo.am.mediation.certificates.CertificateValidator",
    paramTypes: ["long", "int"]
} external;

function com_wso2_choreo_am_mediation_certificates_CertificateValidator_newCertificateValidator1() returns handle = @java:Constructor {
    'class: "com.wso2.choreo.am.mediation.certificates.CertificateValidator",
    paramTypes: []
} external;

