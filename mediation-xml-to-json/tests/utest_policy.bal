import ballerina/http;
import ballerina/test;

xml originalPayload = xml `<greeting><name>John Doe</name><message>Hello World!</message></greeting>`;
json expPayload = {"greeting": {"name": "John Doe", "message": "Hello World!"}};

@test:Config {}
public function testInFlowSingleInstance() {
    http:Request req = new;
    req.setXmlPayload(originalPayload);
    http:Response|false|error|() result = xmlToJsonIn({httpMethod: "get", resourcePath: "/greet"}, req);
    assertResult(result, req.getJsonPayload(), expPayload);
}

@test:Config {}
public function testOutFlowSingleInstance() {
    http:Response res = new;
    res.setXmlPayload(originalPayload);
    http:Response|false|error|() result = xmlToJsonOut({httpMethod: "get", resourcePath: "/greet"}, new, res);
    assertResult(result, res.getJsonPayload(), expPayload);
}

function assertResult(http:Response|false|error|() result, json|http:ClientError payload, json expVal) {
    if !(result is ()) {
        test:assertFail("Expected '()', found " + (typeof result).toString());
    }

    if payload is http:ClientError {
        test:assertFail("Failed to retrieve a valid JSON payload");
    }

    test:assertEquals(payload, expVal);
}
