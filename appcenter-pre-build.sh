#!/usr/bin/env bash -e
source appcenter-slack-webhook.sh

# Remember to declare environment variables in the app center build configuration
if [ ! -n "$PACKAGE_NAME" ]
then
    notify_build_failed
    echo "You need define the PACKAGE_NAME variable in App Center"
    exit 0
fi

# Change iOS bundle name for non-production builds
if [ "$APPCENTER_BRANCH" != "master"  ];
then
    echo "Updating CFBundleName name to $PACKAGE_NAME in Info.plist"
    plutil -replace CFBundleName -string "\$(PRODUCT_NAME) Beta" $APPCENTER_SOURCE_DIRECTORY/MyApp/Info.plist
    
    echo "File content:"
    cat $INFO_PLIST_FILE
fi