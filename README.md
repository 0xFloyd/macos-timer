# I don't want to see the native macos clock app countdown for a timer in my menu bar

I don't want to see the native macos clock app countdown for a timer in my menu bar, so I built this. A simple macOS timer app that lives in your dock (not the menu bar). Set a timer, and get a notification when time's up.

## Build

```
./build_app.sh
```

## Run locally

```bash
./build_app.sh && open MyTimer.app
```

## Features

- Set timer in minutes
- Visual countdown display
- System notification when time's up
- Voice alert ("Timer done")
- No menu bar presence

## Building the App

### Prerequisites

- macOS 12 or later
- Xcode 13 or later with Command Line Tools

### Build Instructions

1. Clone this repository
2. Open Terminal and navigate to the project directory
3. Run:

```bash
swift build -c release
```

4. The executable will be in `.build/release/MyTimer`

### Create App Bundle (optional)

To create a proper app bundle that you can drag to your Applications folder:

1. In project directory, run:

```bash
mkdir -p MyTimer.app/Contents/MacOS
mkdir -p MyTimer.app/Contents/Resources
cp Info.plist MyTimer.app/Contents/
cp .build/release/MyTimer MyTimer.app/Contents/MacOS/
```

2. You can now drag `MyTimer.app` to your Applications folder

## Usage

- Launch the app
- Enter the number of minutes
- Click "Start Timer"
- When time is up, you'll receive both a notification and hear "Timer done"
