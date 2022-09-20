import choreo/mediation;
import ballerina/http;

@mediation:InFlow
public function rewrite(mediation:Context ctx, http:Request req, string newPath) 
                                                                returns http:Response|false|error|() {
    if newPath[0] == "/" {
        ctx.resourcePath = newPath;
    } else {
        ctx.resourcePath = string `/${newPath}`;
    }

    return ();
}
