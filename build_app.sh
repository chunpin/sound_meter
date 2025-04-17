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

# Create Info.plist with proper entries
cat > SoundMeter.app/Contents/Info.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>en</string>
    <key>CFBundleExecutable</key>
    <string>SoundMeter</string>
    <key>CFBundleIdentifier</key>
    <string>com.yourdomain.soundmeter</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleName</key>
    <string>SoundMeter</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>LSMinimumSystemVersion</key>
    <string>12.0</string>
    <key>NSHumanReadableCopyright</key>
    <string>Copyright © 2024. All rights reserved.</string>
    <key>NSMicrophoneUsageDescription</key>
    <string>Sound Meter needs access to your microphone to measure sound levels.</string>
    <key>NSUserNotificationAlertStyle</key>
    <string>alert</string>
    <key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>
    <key>NSAppleEventsUsageDescription</key>
    <string>Sound Meter needs to send notifications.</string>
</dict>
</plist>
EOF

# Copy assets
cp -r Sources/Assets.xcassets SoundMeter.app/Contents/Resources/

# Set executable permissions
chmod +x SoundMeter.app/Contents/MacOS/SoundMeter

# Create a proper app icon
touch SoundMeter.app/Contents/Resources/AppIcon.icns

echo "App bundle created: SoundMeter.app" 