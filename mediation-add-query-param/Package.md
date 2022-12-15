# Add Query Parameter

## Overview

This policy Provides the capability to add additional query parameters to a request.

## Usage

This will be available to select when attaching mediation policies to a proxy in Choreo. The following policy parameters are available:
- `name`: name of the param
- `value`: value of the param

If one needs to add multiple query parameters, one may do so by attaching this policy multiple times. Attaching multiple instances of this policy with the 
same `name` does not overwrite the existing value. Adding multiple values for the same parameter creates an array of values.

Parameter name and value given when attaching the policy will be static values. If you need to be able to make these values configurable
(say, different values for different environments), you can provide input values in the following format. e.g.,
```
name: foo
value: ${fooValue}
```
Then, later on when deploying, you can specify the value for the `fooValue` configurable for each environment.
