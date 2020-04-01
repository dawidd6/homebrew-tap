#!/bin/bash

set -eu

user="$(git config --get user.name)"
email="$(git config --get user.email)"

curl --data "{\"event_type\":\"upload\",\"client_payload\":{\"pr\": $1,\"name\":\"$user\",\"email\":\"$email\"}}" \
     --header "Authorization: token $HOMEBREW_GITHUB_API_TOKEN" \
     'https://api.github.com/repos/dawidd6/homebrew-tap/dispatches'

