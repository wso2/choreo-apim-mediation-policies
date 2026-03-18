# MTLS Authenticator

## Overview

This policy enables mTLS (mutual TLS) authentication for the API. It validates the client certificate against a configured certificate to ensure secure client authentication.

## Usage

This will be available to select when attaching mediation policies to a proxy in Choreo. The following policy parameters are available:
- `Certificate Content`: The expected client certificate content to validate against
- `Optional`: Whether mTLS is optional. If set to `true`, the policy will only validate when a certificate is present; if no certificate is provided, the request will pass through

The policy reads the client certificate from the `x-client-cert-x509` header and validates it against the configured certificate.

If validation fails, the policy returns a `401 Unauthorized` response with an authentication failure message.
