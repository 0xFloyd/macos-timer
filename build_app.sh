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

# Create proper icon file
echo "Creating icon..."
rm -rf MyTimer.iconset 
mkdir -p MyTimer.iconset
for size in 16 32 128 256 512; do
  sips -z $size $size Assets.xcassets/AppIcon.appiconset/clock.png --out MyTimer.iconset/icon_${size}x${size}.png
  sips -z $((size*2)) $((size*2)) Assets.xcassets/AppIcon.appiconset/clock.png --out MyTimer.iconset/icon_${size}x${size}@2x.png
done
iconutil -c icns MyTimer.iconset -o MyTimer.app/Contents/Resources/MyTimer.icns
rm -rf MyTimer.iconset

# Make executable
chmod +x MyTimer.app/Contents/MacOS/MyTimer

echo "App bundle created at $(pwd)/MyTimer.app"
echo "You can now drag this to your Applications folder" 