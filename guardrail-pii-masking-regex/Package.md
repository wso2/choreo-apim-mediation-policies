# PII Masking Regex

## Overview

This package provides a mediation policy for Choreo API Manager that allows you to mask Personally Identifiable Information (PII) in API requests and responses using regular expressions. It is designed to help protect sensitive data by masking it before it reaches the AI proxy component.

## Usage

This will be available to select when attaching mediation policies to an egress AI Proxy Component. The following policy parameters are available:

- `Guardrail Name`: The name of the guardrail policy. This will be used for tracking purposes.
- `PII Entities`: The PII entities to detect and mask using regular expressions. Each entry should include the entity name and its corresponding regex pattern.
- `JSON Path`: The JSONPath expression used to extract content from the payload. If not specified, the entire payload will be used for validation.
- `Redact PII`: When enabled, detected PIIs are redacted and will not be restored to its original form. This should be enabled when the policy is attached to the response flow to prevent exposing AI-generated content with sensitive data to the client. When disabled and applied to the request flow, detected PII is temporarily masked and automatically restored in the corresponding response.

The policy can be attached multiple time to a resource if multiple PII masking is required. The policy can be applied to the request flow and the response flow of the API resource.
