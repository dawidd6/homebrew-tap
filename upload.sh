#!/bin/sh

set -eu

curl --data '{"event_type":"upload","client_payload":{"pr": $1}}' \
     --header "Authorization: token $HOMEBREW_GITHUB_API_TOKEN" \
     'https://api.github.com/repos/dawidd6/homebrew-tap/dispatches'

