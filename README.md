# MacCleanup

A macOS app to reclaim disk space by cleaning developer caches, logs, and system junk — built with SwiftUI.

## Features

- Scans 27+ storage locations and shows sizes live as it scans
- Three groups: **Found** (sorted by size), **Commands** (shell-based cleanup), **Nothing to Clean**
- **Clean All** or **Choose** specific items before deleting
- Confirmation sheet shows exactly what will be deleted and total size
- Tracks clean history per category — last cleaned date, times cleaned, space freed
- Sort by largest or smallest first
- Refresh / re-scan without restarting the app
- Custom accent color and app icon

## Categories Covered

| Category | What it cleans |
|---|---|
| Xcode DerivedData | Build artifacts |
| Xcode Archives | App archives |
| Xcode iOS Device Support | Per-device debug symbols |
| iOS Simulator (Unavailable) | Deleted simulator devices |
| Gradle Caches | Caches, daemon, wrapper dists |
| CocoaPods Cache | Local pod repos |
| Carthage Artifacts | Built Carthage frameworks |
| npm Cache | Node package cache |
| Flutter pub-cache | Dart/Flutter packages |
| Ruby Gems Cache | Gem installations |
| Python pip Cache | pip download cache |
| JetBrains Caches | IntelliJ/Android Studio caches |
| VS Code Cache | Editor cache and cached data |
| Chrome Cache | Browser cache |
| Slack Cache | App and service worker cache |
| Spotify Cache | Music app cache |
| Figma Cache | Offline files |
| Zoom Speech Cache | AI speech models |
| Library/Caches | All app caches |
| Homebrew Cache | Downloaded bottles |
| QuickLook Thumbnails | Preview thumbnails |
| Mail Attachments Cache | Mail app attachments |
| iOS Backups | iPhone/iPad backups |
| Trash | ~/.Trash |
| All Logs | Google, JetBrains, CoreSimulator, DiagnosticReports |
| Docker System Prune | Unused images/containers |
| Wallpaper Aerials | Apple TV aerial wallpapers |

## Requirements

- macOS 15+
- Xcode 26+

## Build & Run

1. Clone the repo
2. Open `MacCleanup.xcodeproj` in Xcode
3. Select your Mac as the run destination
4. Build and run (`Cmd+R`)

> **Note:** App Sandbox is disabled so the app can access all system paths. This app is for personal use only and is not distributed via the App Store.

## Skipped Intentionally

- Android Studio SDK, AVD, NDK — manage these separately to avoid breaking your Android setup

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)

## License

MIT — see [LICENSE](LICENSE)
