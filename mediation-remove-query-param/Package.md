# Remove Query Parameter

## Overview

This policy provides the capability to remove specified query parameters from the request.

## Usage

This will be available to select when attaching mediation policies to a proxy in Choreo. The following policy parameters are available:
- `name`: name of the param

If one needs to remove multiple query parameters, one may do so by attaching this policy multiple times. Attempting to remove a non-existent query parameter 
does not cause any failures. It'll remove if the parameter is present, if not it'll return.
