import SwiftUI

@main
struct MacCleanupApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowResizability(.contentSize)
        .defaultSize(width: 560, height: 520)
    }
}
