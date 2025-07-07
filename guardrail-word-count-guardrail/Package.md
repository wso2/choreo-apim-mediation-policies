# Word Count Guardrail

## Overview

This policy provides the capability to perform word count-based validation on incoming or outgoing JSON payloads. This component acts as a guardrail to enforce specific content moderation rules based on configurable minimum and maximum word counts and JSONPath expressions.

## Usage

This will be available to select when attaching mediation policies to an egress AI Proxy Component in Choreo/Bijira. The following policy parameters are available:

- `Guardrail Name`: The name of the guardrail policy. This will be used for tracking purposes.
- `Minimum Word Count`: The minimum number of words the content must contain.
- `Maximum Word Count`: The maximum number of words the content can contain.
- `JSON Path`: The JSONPath expression used to extract content from the payload. If not specified, the entire payload will be used for validation.
- `Invert the Guardrail Decision`: If enabled, inverts the guardrail blocking decision, causing the guardrail to intervene and return an error response when a match is found in the content.
- `Show Guardrail Assessment`: When enabled, the error response will include detailed information about the reason for the guardrail intervention.

The policy can be attached multiple time to a resource if multiple word count based validation is required. The policy can be applied to the request flow and the response flow of the API resource.
