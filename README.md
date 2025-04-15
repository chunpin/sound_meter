# Sound Meter

A macOS desktop application that monitors and displays real-time environmental sound levels, similar to the Apple Watch Sound Meter app.

## Features

- Real-time sound level monitoring
- Visual gauge display with color indicators
  - Green: Normal sound levels
  - Yellow: Moderate sound levels
  - Red: High sound levels
- Simple start/stop control
- Decibel level display

## Requirements

- macOS 12.0 or later
- Swift 5.5 or later
- Xcode Command Line Tools

## Installation

1. Clone the repository:
```bash
git clone git@github.com:YOUR_USERNAME/sound_meter.git
cd sound_meter
```

2. Build the project:
```bash
swift build
```

3. Run the app:
```bash
swift run
```

## Usage

1. When you first run the app, macOS will ask for permission to access the microphone. Click "Allow" to grant access.

2. The main window will show:
   - A circular gauge showing current sound levels
   - A numerical display of the decibel level
   - A Start/Stop button

3. Click "Start Monitoring" to begin measuring sound levels
   - The gauge will update in real-time
   - Colors indicate sound intensity:
     - Green: Safe levels
     - Yellow: Moderate levels
     - Red: High levels

4. Click "Stop Monitoring" to stop measuring

## Project Structure 