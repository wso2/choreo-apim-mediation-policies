import choreo/mediation;
import ballerina/xmldata;
import ballerina/mime;
import ballerina/http;

@mediation:InFlow
public function xmlToJsonIn(mediation:Context ctx, http:Request req) returns http:Response|false|error|() {
    xml xmlPayload = check req.getXmlPayload();
    json jsonPayload = check xmldata:toJson(xmlPayload);
    req.setPayload(jsonPayload, mime:APPLICATION_JSON);
    return ();
}

@mediation:OutFlow
public function xmlToJsonOut(mediation:Context ctx, http:Request req, http:Response res) returns http:Response|false|error|() {
    xml xmlPayload = check res.getXmlPayload();
    json jsonPayload = check xmldata:toJson(xmlPayload);
    res.setPayload(jsonPayload, mime:APPLICATION_JSON);
    return ();
}

@mediation:FaultFlow
public function xmlToJsonFault(mediation:Context ctx, http:Request req, http:Response? res, http:Response errorRes, error e) returns http:Response|false|error|() {
    xml xmlPayload = check errorRes.getXmlPayload();
    json jsonPayload = check xmldata:toJson(xmlPayload);
    errorRes.setPayload(jsonPayload, mime:APPLICATION_JSON);
    return ();
}
