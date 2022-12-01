# Package Overview

This package contains the mediation policy "Remove Header" available out of the box in Choreo. This policy provides the capability to 
remove headers from either the request or the response flowing through an HTTP proxy created in Choreo. 

## Usage

This will be available to select when attaching mediation policies to a proxy in Choreo. This policy takes a single parameter: `name`.

The policy can be attached multiple times if multiple headers need to be removed. 

Header name given when attaching the policy will be a static value. If you need to be able to make this configurable
(say, different values for different environments), you can provide input values in the following format. e.g.,
```
name: ${headerName}
```
Then, later on when deploying, you can specify the value for the `headerName` configurable for each environment.
