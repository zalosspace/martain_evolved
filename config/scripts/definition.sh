#!/bin/sh

WORD=$(xsel -o --primary)

definition=$(curl -s "https://freedictionaryapi.com/api/v1/entries/en/$WORD" |
  jq -r '.entries[].senses[].definition' | head -3 | sed 's/^/• /; G')

echo "Definition: $definition"
dunstify "DEFINITION" "
<span size='x-large'><b>$WORD</b></span>
$definition"
