import choreo/mediation;
import ballerina/http;

@mediation:InFlow
public function addHeader_In(mediation:Context ctx, http:Request req, string name, string value)
                                                                returns http:Response|false|error|() {
    req.addHeader(name, value);
    return ();
}

@mediation:OutFlow
public function addHeader_Out(mediation:Context ctx, http:Request req, http:Response res, string name, string value)
                                                                                returns http:Response|false|error|() {
    res.addHeader(name, value);
    return ();
}

@mediation:FaultFlow
public function addHeader_Fault(mediation:Context ctx, http:Request req, http:Response? resp, http:Response errFlowResp, 
                                    error e, string name, string value) returns http:Response|false|error|() {
    errFlowResp.addHeader(name, value);
    return ();
}
