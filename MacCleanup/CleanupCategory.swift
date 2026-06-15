import Foundation

struct CleanupCategory: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let paths: [String]
    let shellCommand: String?
    var sizeBytes: Int64 = 0
    var cleaned: Bool = false

    static let all: [CleanupCategory] = [
        // Developer - Xcode
        CleanupCategory(name: "iOS Simulator (Unavailable)", icon: "iphone.slash",      paths: [], shellCommand: "xcrun simctl delete unavailable"),
        CleanupCategory(name: "Xcode DerivedData",           icon: "hammer",             paths: ["~/Library/Developer/Xcode/DerivedData"], shellCommand: nil),
        CleanupCategory(name: "Xcode Archives",              icon: "archivebox",         paths: ["~/Library/Developer/Xcode/Archives"], shellCommand: nil),
        CleanupCategory(name: "Xcode iOS Device Support",   icon: "externaldrive",      paths: ["~/Library/Developer/Xcode/iOS DeviceSupport"], shellCommand: nil),

        // Developer - Build Tools
        CleanupCategory(name: "Gradle Caches",               icon: "gearshape.2",        paths: ["~/.gradle/caches", "~/.gradle/daemon", "~/.gradle/wrapper/dists"], shellCommand: nil),
        CleanupCategory(name: "CocoaPods Cache",             icon: "shippingbox.fill",   paths: ["~/.cocoapods/repos"], shellCommand: nil),
        CleanupCategory(name: "Carthage Artifacts",          icon: "cart",               paths: ["~/Library/Caches/org.carthage"], shellCommand: nil),

        // Developer - Package Managers
        CleanupCategory(name: "npm Cache",                   icon: "shippingbox",        paths: ["~/.npm"], shellCommand: nil),
        CleanupCategory(name: "Flutter pub-cache",           icon: "wind",               paths: ["~/.pub-cache"], shellCommand: nil),
        CleanupCategory(name: "Ruby Gems Cache",             icon: "r.circle",           paths: ["~/.gem"], shellCommand: nil),
        CleanupCategory(name: "Python pip Cache",            icon: "p.circle",           paths: ["~/Library/Caches/pip"], shellCommand: nil),

        // Apps
        CleanupCategory(name: "Chrome Cache",                icon: "globe",              paths: ["~/Library/Caches/Google/Chrome", "~/Library/Application Support/Google/Chrome/Default/OptGuideOnDeviceModel"], shellCommand: nil),
        CleanupCategory(name: "Slack Cache",                 icon: "message",            paths: ["~/Library/Application Support/Slack/Cache", "~/Library/Application Support/Slack/Service Worker/CacheStorage"], shellCommand: nil),
        CleanupCategory(name: "Spotify Cache",               icon: "music.note",         paths: ["~/Library/Caches/com.spotify.client"], shellCommand: nil),
        CleanupCategory(name: "Figma Cache",                 icon: "pencil.and.ruler",   paths: ["~/Library/Application Support/Figma/OfflineFiles"], shellCommand: nil),
        CleanupCategory(name: "Zoom Speech Cache",           icon: "mic",                paths: ["~/Library/Application Support/zoom.us/SpeechLibrary"], shellCommand: nil),

        // Developer - IDEs
        CleanupCategory(name: "JetBrains Caches",            icon: "j.circle",           paths: ["~/Library/Caches/JetBrains"], shellCommand: nil),
        CleanupCategory(name: "VS Code Cache",               icon: "chevron.left.forwardslash.chevron.right", paths: ["~/Library/Application Support/Code/Cache", "~/Library/Application Support/Code/CachedData"], shellCommand: nil),

        // System
        CleanupCategory(name: "Library/Caches (All Apps)",   icon: "internaldrive",      paths: ["~/Library/Caches"], shellCommand: nil),
        CleanupCategory(name: "Homebrew Cache",              icon: "cup.and.saucer",     paths: ["~/Library/Caches/Homebrew"], shellCommand: nil),
        CleanupCategory(name: "QuickLook Thumbnails",        icon: "photo.on.rectangle", paths: ["~/Library/Caches/com.apple.QuickLook.thumbnailcache"], shellCommand: nil),
        CleanupCategory(name: "Mail Attachments Cache",      icon: "envelope",           paths: ["~/Library/Mail/V10/Attachments"], shellCommand: nil),
        CleanupCategory(name: "iOS Backups",                 icon: "iphone",             paths: ["~/Library/Application Support/MobileSync/Backup"], shellCommand: nil),
        CleanupCategory(name: "Trash",                       icon: "trash",              paths: ["~/.Trash"], shellCommand: nil),

        // Logs
        CleanupCategory(name: "All Logs",                    icon: "doc.text",           paths: ["~/Library/Logs/Google", "~/Library/Logs/JetBrains", "~/Library/Logs/CoreSimulator", "~/Library/Logs/DiagnosticReports"], shellCommand: nil),

        // Docker
        CleanupCategory(name: "Docker System Prune",         icon: "shippingbox.and.arrow.backward", paths: [], shellCommand: "docker system prune -f"),

        // Misc
        CleanupCategory(name: "Wallpaper Aerials",           icon: "photo",              paths: ["~/Library/Application Support/com.apple.wallpaper/Store/Originals"], shellCommand: nil),
    ]
}
