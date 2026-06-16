import SwiftUI

// MARK: - Tool

enum Tool: String, CaseIterable, Identifiable {
    case home         = "Dashboard"
    case cleaner      = "Mac Cleaner"
    case largeFinder  = "Large File Finder"
    case uninstaller  = "App Uninstaller"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .home:        "house.fill"
        case .cleaner:     "trash.fill"
        case .largeFinder: "doc.text.magnifyingglass"
        case .uninstaller: "minus.circle.fill"
        }
    }

    var color: Color {
        switch self {
        case .home:        .blue
        case .cleaner:     .accentColor
        case .largeFinder: .orange
        case .uninstaller: .red
        }
    }

    var subtitle: String {
        switch self {
        case .home:        "Overview & stats"
        case .cleaner:     "27 categories"
        case .largeFinder: "Files over 100 MB"
        case .uninstaller: "Apps & leftovers"
        }
    }

    var available: Bool { self == .cleaner || self == .home }
}

// MARK: - Root

struct ContentView: View {
    @State private var manager = CleanupManager()
    @State private var screen: Screen = .scan
    @State private var selectedTool: Tool = .home

    enum Screen { case scan, cleanAll, done }

    var body: some View {
        NavigationSplitView(columnVisibility: .constant(.all)) {
            List(Tool.allCases, selection: $selectedTool) { tool in
                ToolSidebarRow(tool: tool)
                    .tag(tool)
                    .opacity(tool.available ? 1.0 : 0.5)
            }
            .listStyle(.sidebar)
            .navigationSplitViewColumnWidth(220)
            .navigationTitle("MacDevKit")
        } detail: {
            switch selectedTool {
            case .home:    DashboardView(manager: manager, onSelectTool: { selectedTool = $0 })
            case .cleaner: cleanerView
            default:       ComingSoonView(tool: selectedTool)
            }
        }
        .frame(minWidth: 900, minHeight: 620)
    }

    @ViewBuilder
    private var cleanerView: some View {
        switch screen {
        case .scan:
            MacCleanerView(manager: manager, onClean: { screen = .cleanAll })
        case .cleanAll:
            CleanAllView(manager: manager, onDone: { screen = .done })
        case .done:
            DoneView(manager: manager, onRestart: {
                manager.totalFreedBytes = 0
                manager.categories = CleanupCategory.all
                screen = .scan
            })
        }
    }
}

// MARK: - Sidebar Row

struct ToolSidebarRow: View {
    let tool: Tool
    var body: some View {
        HStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(tool.color)
                    .frame(width: 30, height: 30)
                Image(systemName: tool.icon)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .semibold))
            }
            VStack(alignment: .leading, spacing: 1) {
                Text(tool.rawValue)
                    .font(.system(size: 13, weight: .medium))
                Text(tool.subtitle)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 3)
    }
}

// MARK: - Dashboard

struct DashboardView: View {
    var manager: CleanupManager
    let onSelectTool: (Tool) -> Void
    @State private var storageInfo = StorageInfo.load()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                Text("Dashboard")
                    .font(.largeTitle.bold())
                DiskRingView(info: storageInfo)
                VStack(alignment: .leading, spacing: 14) {
                    Text("Tools")
                        .font(.title3.bold())
                    LazyVGrid(
                        columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())],
                        spacing: 14
                    ) {
                        ForEach(Tool.allCases.filter { $0 != .home }) { tool in
                            ToolCard(tool: tool) { onSelectTool(tool) }
                        }
                    }
                }
            }
            .padding(28)
        }
        .background(Color(nsColor: .windowBackgroundColor))
    }
}

// MARK: - Disk Ring

struct DiskRingView: View {
    let info: StorageInfo

    var ringColor: Color {
        info.usedFraction > 0.9 ? .red : info.usedFraction > 0.75 ? .orange : .accentColor
    }

    var body: some View {
        HStack(spacing: 36) {
            ZStack {
                Circle()
                    .stroke(Color.secondary.opacity(0.12), lineWidth: 14)
                Circle()
                    .trim(from: 0, to: CGFloat(info.usedFraction))
                    .stroke(ringColor, style: StrokeStyle(lineWidth: 14, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 1.0), value: info.usedFraction)
                VStack(spacing: 0) {
                    Text("\(Int(info.usedFraction * 100))%")
                        .font(.system(size: 26, weight: .bold, design: .rounded))
                    Text("used")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .frame(width: 110, height: 110)
            VStack(alignment: .leading, spacing: 10) {
                diskStat(label: "Used",  value: info.used.formattedSize,  color: ringColor)
                diskStat(label: "Free",  value: info.free.formattedSize,  color: .secondary)
                diskStat(label: "Total", value: info.total.formattedSize, color: .secondary)
            }
            Spacer()
        }
        .padding(20)
        .background(Color(nsColor: .controlBackgroundColor))
        .cornerRadius(14)
    }

    private func diskStat(label: String, value: String, color: Color) -> some View {
        HStack(spacing: 8) {
            Circle().fill(color).frame(width: 8, height: 8)
            Text(label).font(.subheadline).foregroundColor(.secondary)
            Text(value).font(.subheadline.bold())
        }
    }
}

// MARK: - Tool Card

struct ToolCard: View {
    let tool: Tool
    let onOpen: () -> Void

    var body: some View {
        VStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(tool.color.opacity(0.12))
                    .frame(width: 60, height: 60)
                Image(systemName: tool.icon)
                    .font(.system(size: 28, weight: .medium))
                    .foregroundColor(tool.color)
            }
            VStack(spacing: 4) {
                Text(tool.rawValue)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                Text(tool.subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            Button(tool.available ? "Open" : "Coming Soon") { onOpen() }
                .buttonStyle(.bordered)
                .controlSize(.small)
                .disabled(!tool.available)
        }
        .padding(18)
        .frame(maxWidth: .infinity)
        .background(Color(nsColor: .controlBackgroundColor))
        .cornerRadius(14)
    }
}

// MARK: - Coming Soon

struct ComingSoonView: View {
    let tool: Tool
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(tool.color.opacity(0.1))
                    .frame(width: 80, height: 80)
                Image(systemName: tool.icon)
                    .font(.system(size: 36, weight: .medium))
                    .foregroundColor(tool.color.opacity(0.6))
            }
            Text(tool.rawValue).font(.title2.bold())
            Text("Coming Soon").foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(nsColor: .windowBackgroundColor))
    }
}

// MARK: - Screen 2: Clean with progress

struct CleanAllView: View {
    var manager: CleanupManager
    let onDone: () -> Void

    @State private var currentName = ""
    @State private var progress: Double = 0

    var toClean: [CleanupCategory] {
        if let ids = manager.selectedIDs {
            return manager.categories.filter { ids.contains($0.id) }
        }
        return manager.categories
    }

    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            Image(systemName: "trash.circle.fill")
                .font(.system(size: 64))
                .foregroundColor(.accentColor)
            Text("Cleaning...")
                .font(.title2.bold())
            VStack(spacing: 8) {
                ProgressView(value: progress)
                    .frame(width: 320)
                Text(currentName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(height: 20)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(nsColor: .windowBackgroundColor))
        .task {
            let items = toClean
            for (i, cat) in items.enumerated() {
                currentName = cat.name
                progress = Double(i) / Double(items.count)
                await manager.clean(category: cat)
            }
            progress = 1.0
            onDone()
        }
    }
}

// MARK: - Screen 3: Done

struct DoneView: View {
    var manager: CleanupManager
    let onRestart: () -> Void

    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 72))
                .foregroundColor(.green)
            VStack(spacing: 8) {
                Text("All Done!")
                    .font(.largeTitle.bold())
                Text("You freed up")
                    .font(.title3)
                    .foregroundColor(.secondary)
                Text(manager.totalFreedBytes.formattedSize)
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundColor(.accentColor)
            }
            Button("Scan Again") { onRestart() }
                .buttonStyle(.bordered)
                .controlSize(.large)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(nsColor: .windowBackgroundColor))
    }
}

#Preview {
    ContentView()
}
