# Package Overview

This package contains the mediation policy "Log Message" available out of the box in Choreo. This policy provides the capability to 
log the payload of a request/response flowing through an HTTP proxy created in Choreo. 

## Usage

This will be available to select when attaching mediation policies to a proxy in Choreo. Attaching this policy multiple times while not restricted, will 
only result in duplicate log entries for the same request/response. This will not log the headers or the payload by default. If one needs to log either 
the headers or the payload, one needs to set the parameters `logHeaders` and `logBody` to `true`. If you are logging the headers, there's an additional 
parameter (`excludedHeaders`) which takes a comma separate list of header names for specifying the headers to exclude when logging.

This policy will return an error if payload logging is enabled but the payload cannot be read from the request/response. 
