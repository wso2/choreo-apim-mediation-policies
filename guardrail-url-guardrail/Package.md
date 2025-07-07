# URL Guardrail

## Overview

This policy provides the capability to perform URL validity checks on incoming or outgoing JSON payloads. This component acts as a guardrail to enforce content safety by validating embedded URLs for accessibility or DNS resolution.

## Usage

This will be available to select when attaching mediation policies to an egress AI Proxy Component in Choreo/Bijira. The following policy parameters are available:

- `Guardrail Name`: The name of the guardrail policy. This will be used for tracking purposes.
- `Perform DNS Lookup`: If enabled, a DNS lookup will be performed to validate the extracted URLs. If disabled, a connection attempt will be made instead.
- `Connection Timeout`: The connection timeout for DNS lookups or connection attempts, in milliseconds. If not specified, a default timeout will be used.
- `JSON Path`: The JSONPath expression used to extract content from the payload. If not specified, the entire payload will be used for validation.
- `Show Guardrail Assessment`: When enabled, the error response will include detailed information about the reason for the guardrail intervention.

The policy can be attached multiple time to a resource if multiple URL validations is required. The policy can be applied to the request flow and the response flow of the API resource.
