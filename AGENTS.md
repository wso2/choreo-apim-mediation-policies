# AGENTS.md

## Project Overview

A collection of out-of-the-box mediation and guardrail policies for WSO2 Choreo APIM, written in Ballerina. Each policy is an independent Ballerina package under a top-level directory (e.g., `mediation-add-header/`, `guardrail-regex-guardrail/`).

## Build & Test Commands

**Prerequisites:** Ballerina 2201.5.5, Python 3.10+ with `toml`, `semantic-version`, `gitpython`, `PyGithub` packages.

```bash
# Test a single policy
bal test <policy-dir>          # e.g., bal test mediation-add-header

# Build (test) all policies with version bumps (compares Ballerina.toml version vs packages.json)
python build.py build

# Release (pack, push to Ballerina Central, tag, create GitHub release)
python build.py release
```

The build system only processes policies whose `Ballerina.toml` version is newer than `packages.json`. To trigger a build for a policy, bump the version in its `Ballerina.toml`.

## Architecture

### Policy Types

**Mediation policies** (`mediation-*`) — HTTP request/response manipulation (headers, query params, content transformation, auth, logging).

**Guardrail policies** (`guardrail-*`) — Validation and safety policies for AI/LLM use cases (regex, content length, PII masking, semantic caching, cloud provider integrations). Many guardrail policies are stubs whose real logic runs in the Egress Gateway.

### Policy Structure

Every policy implements up to three annotated flow functions:

```ballerina
@mediation:RequestFlow    // fn(ctx, req, ...params) returns http:Response|false|error|()
@mediation:ResponseFlow   // fn(ctx, req, res, ...params) returns http:Response|false|error|()
@mediation:FaultFlow      // fn(ctx, req, res?, errFlowResp, error, ...params) returns http:Response|false|error|()
```

- Return `()` to continue the mediation chain
- Return `http:Response` to short-circuit with a custom response
- Return `false` to abort
- Return `error` to signal failure

### Parameter Naming Convention

Policy parameters use Ballerina escaped identifiers with backslash-space syntax: `string Header\ Name`. This maps to user-facing parameter names with spaces.

### Package Identity

Each policy's `Ballerina.toml` defines its Ballerina Central identity under the `choreo` org with dot-separated names (e.g., `choreo/mediation.add_header`). The `keywords` field declares supported flows (`choreo-apim-mediation-request-flow`, `choreo-apim-mediation-response-flow`, `choreo-apim-mediation-fault-flow`).

### Version Management

`packages.json` at the repo root tracks the last-released version of each policy. To release a new version: bump the version in the policy's `Ballerina.toml` (must be greater than the `packages.json` entry). The CI/release process handles tagging (`<policy-name-without-mediation-prefix>-v<version>`), GitHub releases, and Ballerina Central publishing.

### Testing

Tests live in `<policy-dir>/tests/utest_policy.bal`. They use Ballerina's `test` module and a helper `createContext()` function to build `mediation:Context` objects. Tests should cover request, response, and fault flows.

## CI/CD

PR builds (`pr-build.yml`) run `python build.py build` against three Ballerina Central environments (Dev, Stage, Prod) in parallel. Release builds (`release-build.yml`) are triggered manually via workflow dispatch.
