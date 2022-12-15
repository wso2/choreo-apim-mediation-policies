# JSON to XML

## Overview

This policy provides the capability to transform a request/response with a 
JSON payload to a request/response with an XML payload. This is only applicable to the request flow and response flow mediation 
sequences. This policy assumes that the request/response payload is JSON. Attempting to 
use it on a request/response with a non-JSON payload will result in premature termination of the mediation flow. For the same reason, 
this policy cannot be attached multiple times to a resource since once it is used, the payload will be an XML value.
