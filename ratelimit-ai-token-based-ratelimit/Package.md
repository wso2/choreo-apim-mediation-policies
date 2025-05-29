# Token Based Rate Limit

## Overview

This policy applies token based rate limiting to the API resource's request flow by setting a maximum allowed prompt, completion and total token count per time unit.

## Usage

This will be available to select when attaching ratelimit policies to an egress AI Proxy Component in Choreo/Bijira. The following policy parameters are available:
- `Max Prompt Token Count`: The number of prompt tokens allowed per time unit
- `Max Completion Token Count`: The number of completion tokens allowed per time unit
- `Max Total Token Count`: The number of total tokens allowed per time unit
- `Time Unit`: The time unit for the rate limiting

The policy can be attached single time to a resource. The policy will be applied to the request flow of the API resource.

