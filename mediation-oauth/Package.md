# OAuth Mediation Policy

## Overview
This policy provides automatic OAuth 2.0 Client Credentials flow implementation for securing API calls. It handles token acquisition, caching, refreshing, and adding appropriate authorization headers to requests.

## Usage
This policy will be available to select when attaching mediation policies to a proxy in Choreo. When configuring this policy, you need to provide the following parameters:

- `tokenEndpointUrl`: The URL of the OAuth token endpoint (required)
- `clientId`: Your OAuth client ID (required)
- `clientSecret`: Your OAuth client secret (required)
- `headerName`: The name of the header to add the token to ex: "Authorization" (required)

This policy will return an error if the token endpoint cannot be reached, credentials are invalid, or the token refresh fails.