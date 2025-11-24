#!/bin/bash

# Replace the default MOTD with the provided argument
# Usage: ./modify-motd.sh "Your Custom MOTD"

MOTD="$1"

# Escape special characters for sed
ESCAPED_MOTD=$(echo "$MOTD" | sed 's/[&/\]/\\&/g')

# Replace the MOTD in server.properties
sed -i "s/motd=.*/motd=$ESCAPED_MOTD/g" server.properties
