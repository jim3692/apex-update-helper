#!/bin/bash

sfdx force:source:retrieve -w 1000 \
    --manifest $0/package.xml
