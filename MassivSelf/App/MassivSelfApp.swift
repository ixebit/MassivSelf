// MassiveSelfApp.swift
// App entry point — sets up SwiftData container and root navigation

import SwiftUI
import SwiftData

@main
struct MassivSelfApp: App {

    @State private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(appState)
                .modelContainer(for: [
                    DayProgress.self,
                    JournalEntry.self,
                    Achievement.self
                ])
        }
    }
}
