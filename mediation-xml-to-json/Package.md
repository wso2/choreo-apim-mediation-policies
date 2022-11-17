# XML to JSON

## Overview

The "XML to JSON" policy is available out-of-the-box in Choreo and provides the capability to transform a request/response with an XML payload 
to a request/response with a JSON payload. There are no policy parameters for this policy. This policy assumes that the request/response 
payload is XML. Attempting to use it on a request/response with a non-XML payload will result in premature termination of the mediation flow. 
For the same reason, this policy cannot be attached multiple times to a resource since once it is used, the payload will be a JSON value.
