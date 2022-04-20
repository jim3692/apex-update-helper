#!/bin/bash

read -r -p "Are you sure you want to deploy? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    sfdx force:source:deploy -w 1000 \
        --ignorewarnings \
        --manifest $0/package.xml \
        --testlevel RunLocalTests
fi
