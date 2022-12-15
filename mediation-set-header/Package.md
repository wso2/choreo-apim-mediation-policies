# Set Header

## Overview
This policy provides the capability to set arbitrary headers to either the request or the response. Setting the same header multiple times will overwrite the existing header value.

## Usage

This will be available to select when attaching mediation policies to a proxy in Choreo. The following policy parameters are available:
- `Header Name`: the header name
- `Header Value`: the header value

The policy can be attached multiple times if multiple headers need to be set. Setting the same header multiple times will overwrite the 
existing header value.

Header name and value given when attaching the policy will be static values. If you need to be able to make these values configurable
(say, different values for different environments), you can provide input values in the following format. e.g.,
```
name: Authorization
value: ${authzHeaderValue}
```
Then, later on when deploying, you can specify the value for the `authzHeaderValue` configurable for each environment.
