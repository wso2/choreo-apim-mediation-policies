# AWS Bedrock Guardrail

## Overview

This policy provides the capability to integrate with AWS Bedrock Guardrails to enable real-time content safety validation and PII protection for AI applications. Through the configured Bedrock Guardrail, it can detect and block harmful content (hate speech, sexual content, self-harm, violence) and mask or redact Personally Identifiable Information (PII) in both request and response payloads. This integration helps ensure AI applications meet safety standards and compliance requirements while protecting against malicious prompt injection attacks.

## Usage

This will be available to select when attaching mediation policies to an egress AI Proxy Component. The following policy parameters are available:

- `Guardrail Name`: The name of the guardrail policy. This will be used for tracking purposes.
- `AWS Guardrail ID`: The ID of the AWS Bedrock Guardrail resource.
- `AWS Guardrail Version`: The version of the AWS Bedrock Guardrail resource.
- `AWS Guardrail Region`: The deployed region of the AWS Bedrock Guardrail resource.
- `AWS Access Key ID`: The AWS Access Key ID used to authenticate with the AWS Bedrock service.
- `AWS Secret Access Key`: The AWS Secret Access Key used to authenticate with the AWS Bedrock service.
- `AWS Session Token`: The AWS Session Token used to authenticate with the AWS Bedrock service.
- `AWS Role ARN`: The ARN of the IAM role to assume for accessing the AWS Bedrock Guardrail service. This is optional and can be used if you want to use a role instead of access keys.
- `AWS Role Region`: The AWS region where the IAM role is deployed. This is optional and can be used if you want to use a role instead of access keys.
- `AWS Role External ID`: The external ID used for the AWS role assumption. This is optional and can be used if you want to use a role instead of access keys.
- `JSON Path`: The JSONPath expression used to extract content from the payload. If not specified, the entire payload will be used for validation.
- `Redact PII`: When enabled, detected PIIs are redacted and will not be restored to its original form. This should be enabled when the policy is attached to the response flow to prevent exposing AI-generated content with sensitive data to the client. When disabled and applied to the request flow, detected PII is temporarily masked and automatically restored in the corresponding response.
- `Passthrough on Error`: If enabled, the request or response is passed through without validation when the AWS Bedrock service is unavailable. Otherwise, a guardrail validation error is triggered.
- `Show Guardrail Assessment`: When enabled, the error response will include detailed information about the reason for the guardrail intervention.

The policy can be attached multiple time to a resource if multiple AWS Bedrock Guardrails are required. The policy can be applied to the request flow and the response flow of the API resource.
