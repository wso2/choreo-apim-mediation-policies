# Rewrite Resource Path

## Overview

This policy provides the capability to modify the resource path segment 
(i.e., the endpoint of the upstream API) of an HTTP request. The original resource path 
will be replaced by the provided relative resource path.

## Usage

This will be available to select when attaching mediation policies to a proxy in Choreo. The following policy parameters are available:
- `newPath`: the desired resource path to route to. Path params can be referred to using the following format: `{pathParam}`. For example, if the resource in the proxy is `/foo/{id}`, user can specify the `newPath` as `/arbitrary/path/{id}/more/segments`. This policy is only applicable to the request flow sequence.
- `keepQueryParams`: whether to keep the query params of the request or not.

While there's no restriction on adding this policy multiple times, it would not be useful to do so. The resource path given in the last instance of 
this policy will be the one that'd be used.

The resource path given when attaching the policy will be static. If you need to be able to make the path configurable
(say, different paths for different environments), you can provide input value in the following format. e.g.,
```
newPath: ${myResourcePath}
```
Then, later on when deploying, you can specify the value for the `myResourcePath` configurable for each environment.
