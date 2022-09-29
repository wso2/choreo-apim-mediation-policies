import ballerina/http;
import ballerina/test;

json originalPayload = {"name":"John Doe", "greeting":"Hello World!"};
xml expPayload = xml `<root><name>John Doe</name><greeting>Hello World!</greeting></root>`;

@test:Config {}
public function testInFlowSingleInstance() {
    http:Request req = new;
    req.setJsonPayload(originalPayload);
    http:Response|false|error|() result = jsonToXmlIn({httpMethod: "get", resourcePath: "/greet"}, req);
    assertResult(result, req.getXmlPayload(), expPayload);
}

@test:Config {}
public function testOutFlowSingleInstance() {
    http:Response res = new;
    res.setJsonPayload(originalPayload);
    http:Response|false|error|() result = jsonToXmlOut({httpMethod: "get", resourcePath: "/greet"}, new, res);
    assertResult(result, res.getXmlPayload(), expPayload);
}

function assertResult(http:Response|false|error|() result, xml|http:ClientError payload, xml expVal) {
    if !(result is ()) {
        test:assertFail("Expected '()', found " + (typeof result).toString());
    }

    if payload is http:ClientError {
        test:assertFail("Failed to retrieve a valid XML payload");
    }

    test:assertEquals(payload, expVal);
}
