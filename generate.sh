#!/bin/bash

ROOT_PATH=$(dirname "$0")
if [ ! -f $ROOT_PATH/applications.list ]; then
    echo "$ROOT_PATH/applications.list File not found!"
    exit 0
fi

if [ ! -d $ROOT_PATH/templates ]; then
    echo "$ROOT_PATH/templates Folder not found!"
    exit 0
fi

echo "$(date) STARTED"
NOW=$(date +%Y%m%d_%H%M%S)
mkdir -p $ROOT_PATH/$NOW

LOWER_DASH_KEY="XlowerdashapplicatonnameX"
LOWER_UNDERSCORE_KEY="XlowerunderscoreapplicatonnameX"
UPPER_UNDERSCORE_KEY="XUPPERUNDERSCOREAPLICATIONNAMEX"

for APLICATION_NAME in $(cat $ROOT_PATH/applications.list); do
    mkdir -p $ROOT_PATH/$NOW/$APLICATION_NAME
    LOWER_UNDERSCORE=$(echo $APLICATION_NAME | sed 's/\-/_/g')
    UPPER_UNDERSCORE=$(echo $LOWER_UNDERSCORE | tr /a-z/ /A-Z/)
    for TEMPLATE_FILE in $ROOT_PATH/templates/*; do
        sed "s/${LOWER_DASH_KEY}/${APLICATION_NAME}/g; s/${LOWER_UNDERSCORE_KEY}/${LOWER_UNDERSCORE}/g; s/${UPPER_UNDERSCORE_KEY}/${UPPER_UNDERSCORE}/g;" $TEMPLATE_FILE > $ROOT_PATH/$NOW/$APLICATION_NAME/$(basename $TEMPLATE_FILE)
    done;
    echo $APLICATION_NAME DONE!
done

echo "$(date) FINISHED"
