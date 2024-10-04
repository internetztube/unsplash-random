#!/usr/bin/env bash

# Get your Unsplash Access Key it from here:
# https://unsplash.com/oauth/applications/new
# UNSPLASH_ACCESS_KEY=""

# Multi line string of Unsplash usernames.
# The Unsplash Demo API has a Rate Limit of 50 requests per hour. Therefore, you can put up to 50 usernames in here.
# UNSPLASH_USERNAMES="internetztube"

# FALLBACK_TARGET="https://github.com/internetztube/unsplash-random"
FILENAME="_redirects"

rm $FILENAME
touch $FILENAME

echo "$UNSPLASH_USERNAMES" | while read -r username; do
  username=$(echo "$username" | xargs)

  if [ -n "$username" ]; then
    response=$(curl -s "https://api.unsplash.com/photos/random?username=${username}&client_id=${UNSPLASH_ACCESS_KEY}")
    response=$(echo $response | tr -d '\000-\037')

    for url in $(echo $response | jq -r '.urls | to_entries[] | "\(.key)=\(.value)"'); do
      echo "/$username/${url%%=*} ${url#*=} 302" >> $FILENAME
    done

  fi
done

if ! [ -z "$FALLBACK_TARGET" ]; then
  echo "/* ${FALLBACK_TARGET} 301" >> $FILENAME
fi
