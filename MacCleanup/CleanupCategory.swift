import Foundation

struct CleanupCategory: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let paths: [String]
    let subpath: String?
    let shellCommand: String?
    var sizeBytes: Int64 = 0
    var fileCount: Int = 0
    var freedBytes: Int64 = 0
    var cleaned: Bool = false

    static let all: [CleanupCategory] = [
        // Developer - Xcode
        CleanupCategory(name: "iOS Simulator (Unavailable)", icon: "iphone.slash",      paths: [], subpath: nil, shellCommand: "xcrun simctl delete unavailable"),
        CleanupCategory(name: "Xcode DerivedData",           icon: "hammer",             paths: ["~/Library/Developer/Xcode/DerivedData"], subpath: nil, shellCommand: nil),
        CleanupCategory(name: "Xcode Archives",              icon: "archivebox",         paths: ["~/Library/Developer/Xcode/Archives"], subpath: nil, shellCommand: nil),
        CleanupCategory(name: "Xcode iOS Device Support",   icon: "externaldrive",      paths: ["~/Library/Developer/Xcode/iOS DeviceSupport"], subpath: nil, shellCommand: nil),

        // Developer - Build Tools
        CleanupCategory(name: "Gradle Caches",               icon: "gearshape.2",        paths: ["~/.gradle/caches", "~/.gradle/daemon", "~/.gradle/wrapper/dists"], subpath: nil, shellCommand: nil),
        CleanupCategory(name: "CocoaPods Cache",             icon: "shippingbox.fill",   paths: ["~/.cocoapods/repos"], subpath: nil, shellCommand: nil),
        CleanupCategory(name: "Carthage Artifacts",          icon: "cart",               paths: ["~/Library/Caches/org.carthage"], subpath: nil, shellCommand: nil),

        // Developer - Package Managers
        CleanupCategory(name: "npm Cache",                   icon: "shippingbox",        paths: ["~/.npm"], subpath: nil, shellCommand: nil),
        CleanupCategory(name: "Yarn Cache",                  icon: "shippingbox.fill",   paths: ["~/.yarn/cache"], subpath: nil, shellCommand: nil),
        CleanupCategory(name: "pnpm Store",                  icon: "shippingbox.and.arrow.backward.fill", paths: ["~/.pnpm-store", "~/Library/pnpm/store"], subpath: nil, shellCommand: nil),
        CleanupCategory(name: "Flutter pub-cache",           icon: "wind",               paths: ["~/.pub-cache"], subpath: nil, shellCommand: nil),
        CleanupCategory(name: "FVM SDK Cache",               icon: "f.circle",           paths: ["~/fvm/versions"],  subpath: "bin/cache", shellCommand: nil),
        CleanupCategory(name: "Ruby Gems Cache",             icon: "r.circle",           paths: ["~/.gem"], subpath: nil, shellCommand: nil),
        CleanupCategory(name: "Python pip Cache",            icon: "p.circle",           paths: ["~/Library/Caches/pip"], subpath: nil, shellCommand: nil),
        CleanupCategory(name: "Maven Local Repo",            icon: "m.circle",           paths: ["~/.m2/repository"], subpath: nil, shellCommand: nil),
        CleanupCategory(name: "Cargo Registry Cache",        icon: "c.circle",           paths: ["~/.cargo/registry/cache"], subpath: nil, shellCommand: nil),
        CleanupCategory(name: "Go Module Cache",             icon: "g.circle",           paths: ["~/go/pkg/mod/cache"], subpath: nil, shellCommand: nil),
        CleanupCategory(name: "Android AVD",                 icon: "candybarphone",      paths: ["~/.android/avd"], subpath: nil, shellCommand: nil),
        CleanupCategory(name: "Android Cache",               icon: "a.circle",           paths: ["~/.android/cache"], subpath: nil, shellCommand: nil),

        // Apps
        CleanupCategory(name: "Chrome Cache",                icon: "globe",              paths: ["~/Library/Caches/Google/Chrome", "~/Library/Application Support/Google/Chrome/Default/OptGuideOnDeviceModel"], subpath: nil, shellCommand: nil),
        CleanupCategory(name: "Slack Cache",                 icon: "message",            paths: ["~/Library/Application Support/Slack/Cache", "~/Library/Application Support/Slack/Service Worker/CacheStorage"], subpath: nil, shellCommand: nil),
        CleanupCategory(name: "Spotify Cache",               icon: "music.note",         paths: ["~/Library/Caches/com.spotify.client"], subpath: nil, shellCommand: nil),
        CleanupCategory(name: "Figma Cache",                 icon: "pencil.and.ruler",   paths: ["~/Library/Application Support/Figma/OfflineFiles"], subpath: nil, shellCommand: nil),
        CleanupCategory(name: "Zoom Speech Cache",           icon: "mic",                paths: ["~/Library/Application Support/zoom.us/SpeechLibrary"], subpath: nil, shellCommand: nil),

        // Developer - IDEs
        CleanupCategory(name: "JetBrains Caches",            icon: "j.circle",           paths: ["~/Library/Caches/JetBrains"], subpath: nil, shellCommand: nil),
        CleanupCategory(name: "VS Code Cache",               icon: "chevron.left.forwardslash.chevron.right", paths: ["~/Library/Application Support/Code/Cache", "~/Library/Application Support/Code/CachedData"], subpath: nil, shellCommand: nil),

        // System
        CleanupCategory(name: "Library/Caches (All Apps)",   icon: "internaldrive",      paths: ["~/Library/Caches"], subpath: nil, shellCommand: nil),
        CleanupCategory(name: "Homebrew Cache",              icon: "cup.and.saucer",     paths: ["~/Library/Caches/Homebrew"], subpath: nil, shellCommand: nil),
        CleanupCategory(name: "QuickLook Thumbnails",        icon: "photo.on.rectangle", paths: ["~/Library/Caches/com.apple.QuickLook.thumbnailcache"], subpath: nil, shellCommand: nil),
        CleanupCategory(name: "Mail Attachments Cache",      icon: "envelope",           paths: ["~/Library/Mail/V10/Attachments"], subpath: nil, shellCommand: nil),
        CleanupCategory(name: "iOS Backups",                 icon: "iphone",             paths: ["~/Library/Application Support/MobileSync/Backup"], subpath: nil, shellCommand: nil),
        CleanupCategory(name: "Trash",                       icon: "trash",              paths: ["~/.Trash"], subpath: nil, shellCommand: nil),

        // Logs
        CleanupCategory(name: "All Logs",                    icon: "doc.text",           paths: ["~/Library/Logs/Google", "~/Library/Logs/JetBrains", "~/Library/Logs/CoreSimulator", "~/Library/Logs/DiagnosticReports"], subpath: nil, shellCommand: nil),

        // Docker
        CleanupCategory(name: "Docker System Prune",         icon: "shippingbox.and.arrow.backward", paths: [], subpath: nil, shellCommand: "docker system prune -f"),

        // Misc
        CleanupCategory(name: "Wallpaper Aerials",           icon: "photo",              paths: ["~/Library/Application Support/com.apple.wallpaper/Store/Originals"], subpath: nil, shellCommand: nil),
    ]
}
