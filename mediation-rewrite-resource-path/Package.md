# Package Overview

This package contains the mediation policy "Rewrite Resource Path" which is available out of the box in Choreo. This policy provides the capability to 
modify resource path of a request going through a proxy created in Choreo.

## Usage

This will be available to select when attaching mediation policies to a proxy in Choreo. The following policy parameters are available:
- `newPath`: the desired resource path to route to.  This policy is only applicable to the in-flow sequence.

While there's no restriction on adding this policy multiple times, it would not be useful to do so. The resource path given in the last instance of 
this policy will be the one that'd be used.

The resource path given when attaching the policy will be static. If you need to be able to make the path configurable
(say, different paths for different environments), you can provide input value in the following format. e.g.,
```
newPath: ${myResourcePath}
```
Then, later on when deploying, you can specify the value for the `myResourcePath` configurable for each environment.
