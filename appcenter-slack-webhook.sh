#!/usr/bin/env bash -e
ORG=DualogAS
APP=Dualog.CrewConnection.App

# Remember to declare environment variables in the app center build configuration
build_url=https://appcenter.ms/orgs/$ORG/apps/$APP/build/branches/$APPCENTER_BRANCH/builds/$APPCENTER_BUILD_ID

# Enclosing urls with <> makes them clickable in slack
build_link="<$build_url|$APP $APPCENTER_BRANCH #$APPCENTER_BUILD_ID>"

notify() 
{
    # Local variables
    local message
    local "${@}"

    # Using the --data-urlencode curl parameter will automatically URL encodes the provided string
    curl -X POST --data-urlencode "payload={ \"username\": \"App Center\", \"text\": \"$message\" }" $SLACK_WEBHOOK
}

notify_build_passed() 
{
    notify message="✔ $build_link built"
}

notify_build_failed() 
{
    notify message="❌ $build_link build failed"
}
