# PII Masking Guardrails AI

## Overview

This policy provides the capability to mask personally identifiable information (PII) in AI-generated content using Guardrails AI. It allows for the detection and masking of specified PII entities in both request and response payloads. This integration helps ensure that AI applications comply with data protection regulations while preventing the exposure of sensitive information.

## Usage

This will be available to select when attaching mediation policies to an egress AI proxy component. The following policy parameters are available:

- `Guardrail Name`: The name of the guardrail policy. This will be used for tracking purposes.
- `PII Entities`: The list of PII entities to be masked in the content.
- `JSON Path`: The JSONPath expression used to extract content from the payload. If not specified, the entire payload will be used for validation.
- `Redact PII`: When enabled, detected PIIs are redacted and will not be restored to its original form. This should be enabled when the policy is attached to the response flow to prevent exposing AI-generated content with sensitive data to the client. When disabled and applied to the request flow, detected PII is temporarily masked and automatically restored in the corresponding response.

The policy can be attached multiple time to a resource if multiple PII masking is required. The policy can be applied to the request flow and the response flow of the API resource.
