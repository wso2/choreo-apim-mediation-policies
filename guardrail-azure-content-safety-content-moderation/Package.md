# Azure Content Safety Content Moderation

## Overview

This policy provides the capability to integrate Azure Content Safety Content Moderation Service to filter out harmful content in request bodies and AI-generated responses. This guardrail checks for hate speech, sexual content, self-harm, and violence, and can be applied to both requests and responses.

## Usage

This will be available to select when attaching mediation policies to an egress AI Proxy Component. The following policy parameters are available:

- `Guardrail Name`: The name of the guardrail policy. This will be used for tracking purposes.
- `Azure Content Safety Endpoint`: The endpoint URL of the Azure Content Safety service.
- `Azure Content Safety Key`: The API key for authenticating with the Azure Content Safety service.
- `Hate Severity Level`: The severity level for the hate category.
- `Sexual Severity Level`: The severity level for the sexual content category.
- `Self Harm Severity Level`: The severity level for the self-harm category.
- `Violence Severity Level`: The severity level for the violence category.
- `JSON Path`: The JSONPath expression used to extract content from the payload. If not specified, the entire payload will be used for validation.
- `Passthrough on Error`: If enabled, the request or response is passed through without validation when the Azure Content Safety service is unavailable. Otherwise, a guardrail validation error is triggered.
- `Show Guardrail Assessment`: When enabled, the error response will include detailed information about the reason for the guardrail intervention.

The policy can be attached multiple time to a resource if multiple Azure Content Safety Content Moderations are required. The policy can be applied to the request flow and the response flow of the API resource.
