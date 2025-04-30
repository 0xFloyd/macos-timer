#!/bin/bash

# Build the app
echo "Building MyTimer..."
swift build -c release

if [ $? -ne 0 ]; then
    echo "Build failed!"
    exit 1
fi

# Create app bundle
echo "Creating app bundle..."
mkdir -p MyTimer.app/Contents/MacOS
mkdir -p MyTimer.app/Contents/Resources

# Copy files
cp Info.plist MyTimer.app/Contents/
cp .build/release/MyTimer MyTimer.app/Contents/MacOS/

echo "App bundle created at $(pwd)/MyTimer.app"
echo "You can now drag this to your Applications folder" 