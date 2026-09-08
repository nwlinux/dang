# dang

A tiny iOS app for counting how many times your mother in law says "dang" today.

Tap the big red DANG! button each time it happens. The count resets automatically
each day, and past days are kept in a history list on the same screen.

## Requirements

- A Mac with Xcode 15 or newer installed
- An iPhone (or the iOS Simulator) to run it on
- A free Apple ID is enough to install it on your own device for personal use

## Running it on your iPhone

1. Clone this repo and open `DangCounter/DangCounter.xcodeproj` in Xcode.
2. Select the `DangCounter` target, then in the project settings under
   "Signing & Capabilities" choose your Apple ID as the Team (Xcode will
   handle signing automatically).
3. Plug in your iPhone (or select it wirelessly if already paired), choose it
   as the run destination in the toolbar, and press Run (Cmd+R).
4. The first time you run it, on your iPhone go to
   Settings > General > VPN & Device Management and trust your developer
   certificate.

With a free Apple ID the app's signature needs to be refreshed by re-running
from Xcode roughly every 7 days. A paid Apple Developer account (or
distributing through TestFlight) removes that limit.

## How it works

- `CounterStore.swift` keeps a dictionary of counts keyed by day
  (`yyyy-MM-dd`) in `UserDefaults`, so today's count is whatever is stored
  under today's key.
- `ContentView.swift` shows today's count, the DANG! button, an Undo button
  for accidental taps, a Reset Today button, and a scrollable history of
  previous days.
- `DangCounterApp.swift` is the SwiftUI app entry point.

## Project layout

```
DangCounter/
  DangCounter.xcodeproj/     Xcode project file
  DangCounter/
    DangCounterApp.swift     App entry point
    ContentView.swift        Main UI
    CounterStore.swift       Persistence and daily counting logic
    Assets.xcassets/         App icon and accent color placeholders
```
