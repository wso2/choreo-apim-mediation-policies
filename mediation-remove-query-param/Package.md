# Package Overview

This package contains the mediation policy "Remove Query Param" which is available out of the box in Choreo. This policy provides the capability to remove specified query parameters from a request flowing through a proxy created in Choreo.

## Usage

This will be available to select when attaching mediation policies to a proxy in Choreo. The following policy parameters are available:
- `name`: name of the param

If one needs to remove multiple query parameters, one may do so by attaching this policy multiple times. Attempting to remove a non-existent query parameter 
does not cause any failures. It'll remove if the parameter is present, if not it'll return.
