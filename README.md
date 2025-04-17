# Sound Meter

A macOS application that monitors sound levels and alerts you when they exceed a configurable threshold.

## Features

- Real-time sound level monitoring
- Configurable threshold for alerts
- Background operation
- macOS notifications when threshold is exceeded
- Clean and intuitive user interface

## Requirements

- macOS 12.0 or later
- Xcode Command Line Tools
- Swift 5.5 or later

## Building the App Bundle

### Prerequisites

1. Install Xcode Command Line Tools:
```bash
xcode-select --install
```

2. Verify Swift installation:
```bash
swift --version
```

### Building Steps

1. Clone the repository:
```bash
git clone <repository-url>
cd sound_meter
```

2. Make the build script executable:
```bash
chmod +x build_app.sh
```

3. Build the app bundle:
```bash
./build_app.sh
```

This will create a `SoundMeter.app` bundle in your current directory.

## Running the App

### First Run

1. Double-click `SoundMeter.app` in Finder, or run:
```bash
open SoundMeter.app
```

2. On first run, you'll need to grant permissions:
   - Allow microphone access when prompted
   - Allow notifications when prompted

### Using the App

1. Adjust the threshold using the slider (default is 30 dB)
2. Click "Start Monitoring" to begin background monitoring
3. The app will show notifications when sound levels exceed the threshold
4. You can close the window and the app will continue monitoring in the background
5. To quit the app, use Command+Q or select Quit from the menu bar

## App Bundle Structure

The app bundle (`SoundMeter.app`) contains:

```
SoundMeter.app/
├── Contents/
│   ├── Info.plist
│   ├── MacOS/
│   │   └── SoundMeter
│   └── Resources/
│       └── Assets.xcassets
```

## Troubleshooting

1. If the app crashes on launch:
   - Check if you have granted microphone permissions
   - Verify that notifications are enabled in System Preferences
   - Try rebuilding the app bundle

2. If notifications don't work:
   - Check System Preferences > Notifications > Sound Meter
   - Ensure notifications are enabled for the app

3. If sound monitoring doesn't work:
   - Check System Preferences > Security & Privacy > Microphone
   - Ensure Sound Meter has microphone access

## Development

### Building from Source

To build the app directly from source (for development):

```bash
swift build
swift run
```

### Project Structure

```
sound_meter/
├── Sources/
│   ├── AudioManager.swift
│   ├── ContentView.swift
│   ├── SoundMeterApp.swift
│   ├── Info.plist
│   └── Assets.xcassets/
├── Package.swift
└── build_app.sh
```

## License

Copyright © 2024. All rights reserved. 