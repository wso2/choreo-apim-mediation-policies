# Content Length Guardrail

## Overview

This policy provides the capability to perform content-byte-length validation on incoming or outgoing JSON payloads. This component acts as a guardrail to enforce specific content moderation rules based on configurable minimum and maximum byte sizes and JSONPath expressions.

## Usage

This will be available to select when attaching mediation policies to an egress AI proxy component. The following policy parameters are available:

- `Guardrail Name`: The name of the guardrail policy. This will be used for tracking purposes.
- `Minimum Content Length`: The minimum number of bytes the content must contain.
- `Maximum Content Length`: The maximum number of bytes the content must contain.
- `JSON Path`: The JSONPath expression used to extract content from the payload. If not specified, the entire payload will be used for validation.
- `Invert the Guardrail Decision`: If enabled, inverts the guardrail blocking decision, causing the guardrail to intervene and return an error response when the content is within the specified limits.
- `Show Guardrail Assessment`: When enabled, the error response will include detailed information about the reason for the guardrail intervention.

The policy can be attached multiple time to a resource if multiple content length based validations is required. The policy can be applied to the request flow and the response flow of the API resource.
