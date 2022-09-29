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
