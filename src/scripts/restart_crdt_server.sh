#!/usr/bin/env bash
set -euo pipefail

# for CRDT
curl -X POST https://backboard.railway.com/graphql/v2 \
  -H "Content-Type: application/json" \
  -H "Project-Access-Token: 3bfd294c-fc81-4c2d-a915-8b4bc7182cb5" \
  -d '{
    "query": "mutation($env: String!, $svc: String!) { serviceInstanceRedeploy(environmentId: $env, serviceId: $svc) }",
    "variables": {
      "env": "2e195c38-e03d-4fc0-a268-d8c5b91e293b",
      "svc": "e134afba-52de-4158-a618-00a6f4d46903"
    }
  }'



# for openclaw
# curl -X POST https://backboard.railway.com/graphql/v2 \
#   -H "Content-Type: application/json" \
#   -H "Project-Access-Token: 3bfd294c-fc81-4c2d-a915-8b4bc7182cb5" \
#   -d '{
#     "query": "mutation($env: String!, $svc: String!) { serviceInstanceRedeploy(environmentId: $env, serviceId: $svc) }",
#     "variables": {
#       "env": "2e195c38-e03d-4fc0-a268-d8c5b91e293b",
#       "svc": "70671713-96ee-4278-bc6d-dfdac203b2df"
#     }
#   }'