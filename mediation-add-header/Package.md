# Package Overview

This package contains the mediation policy "Add Header" available out of the box in Choreo. This policy provides the capability to add 
arbitrary headers to either the request or the response flowing through an HTTP proxy created in Choreo. 

## Usage

This will be available to select when attaching mediation policies to a proxy in Choreo. The following policy parameters are available:
- `name`: the header name
- `value`: the header value

The policy can be attached multiple times if multiple headers need to be added. Adding the same header multiple times will not 
overwrite the existing header values. It will be a list of values mapped to the same header name.

Header name and value given when attaching the policy will be static values. If you need to be able to make these values configurable
(say, different values for different environments), you can provide input values in the following format. e.g.,
```
name: Authorization
value: ${authzHeaderValue}
```
Then, later on when deploying, you can specify the value for the `authzHeaderValue` configurable for each environment.
