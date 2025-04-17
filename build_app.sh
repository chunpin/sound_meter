#!/bin/bash

# Clean previous build
rm -rf .build
rm -rf SoundMeter.app

# Build the executable
swift build -c release

# Create app bundle structure
mkdir -p SoundMeter.app/Contents/MacOS
mkdir -p SoundMeter.app/Contents/Resources

# Copy the executable
cp .build/release/SoundMeter SoundMeter.app/Contents/MacOS/

# Copy Info.plist
cp Sources/Info.plist SoundMeter.app/Contents/

# Copy assets
cp -r Sources/Assets.xcassets SoundMeter.app/Contents/Resources/

# Set bundle identifier
/usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier com.yourdomain.soundmeter" SoundMeter.app/Contents/Info.plist

# Set executable permissions
chmod +x SoundMeter.app/Contents/MacOS/SoundMeter

echo "App bundle created: SoundMeter.app" 