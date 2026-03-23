// MassiveSelfApp.swift
// App entry point — sets up SwiftData container and root navigation

import SwiftUI
import SwiftData

@main
struct MassivSelfApp: App {

    @State private var appState = AppState()
    @State private var containerError: Error?

    let container: ModelContainer = {
        do {
            return try ModelContainer(for: DayProgress.self, JournalEntry.self, Achievement.self)
        } catch {
            // Fallback: in-memory container
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            return try! ModelContainer(for: DayProgress.self, JournalEntry.self, Achievement.self, configurations: config)
        }
    }()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(appState)
                .modelContainer(container)
        }
    }
}
