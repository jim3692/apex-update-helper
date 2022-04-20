#!/bin/bash

CLASSES_PATH="main/default/classes"
TRIGGERS_PATH="main/default/triggers"

function __deleteOldFiles () {
    find -L $CLASSES_PATH -print | egrep "\w.cls-meta.xml" | while read line; do rm $line; done
    find -L $TRIGGERS_PATH -print | egrep "\w.trigger-meta.xml" | while read line; do rm $line; done
    [ -d .dist ] && rm -rf .dist
}

# function __deleteOldClassesFromOrg () {
#     sfdx force:mdapi:listmetadata -m ApexClass
# }

__deleteOldFiles
find -L $CLASSES_PATH -print | egrep "\.cls$" | while read line; do cp "../meta/.cls-meta.xml" "${line}-meta.xml"; done
find -L $TRIGGERS_PATH -print | egrep "\.trigger$" | while read line; do cp "../meta/.trigger-meta.xml" "${line}-meta.xml"; done

sfdx force:source:convert -d .dist
sfdx force:source:deploy -c -w 1000 \
    --ignorewarnings \
    --manifest .dist/package.xml \
    --testlevel RunLocalTests \
    -u $1

__deleteOldFiles
