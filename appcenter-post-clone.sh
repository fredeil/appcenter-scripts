#!/usr/bin/env bash 

# Download and install NPM if it is not already installed (all App Center build server should hav this tho)
npm -v &>/dev/null
if [ $? -ne 0 ]; then
    # Install npm
    echo "Installing npm..."
    brew install npm
    if [ $? -ne 0 ]; then
        echo "An error occured while downloading npm."
        exit 1
    fi 
fi


# Is App Center CLI installed? (all App Center build server should hav this tho)
npm list -g appcenter-cli >/dev/null
if [ $? -ne 0 ]; then
    # Install App Center CLI
    echo "Installing App Center CLI..."
    npm install -g appcenter-cli
    if [ $? -ne 0 ]; then
        echo "An error occured while installing App Center CLI."
        exit 1
    fi
fi

# Log in to App Center
echo "Logging in to App Center..."
appcenter login --token "$APP_CENTER_API_TOKEN"
if [ $? -ne 0 ]; then
    echo "An error occured while logging into App Center."
    exit 1
fi
