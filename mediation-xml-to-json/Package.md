# Package Overview

This package contains the mediation policy "XML to JSON" available out of the box in Choreo. This policy provides the capability to transform 
a request/response XML payload to a request/response with a JSON payload.

## Usage

This will be available to select when attaching mediation policies to a proxy in Choreo. There are no policy parameters for this policy. 
This policy assumes that the request/response payload is XML. Attempting to use it on a request/response with a non-XML payload will result in
premature termination of the mediation flow. For the same reason, this policy cannot be attached multiple times to a resource since once it is used 
the payload will be a JSON value.
