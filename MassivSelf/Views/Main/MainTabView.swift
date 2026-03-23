// MainTabView.swift
// Root tab navigation — 4 tabs with Japanese-minimal styling

import SwiftUI
import SwiftData

struct MainTabView: View {

    // MARK: - Environment

    @Environment(AppState.self) private var appState
    @Environment(\.modelContext) private var modelContext

    // MARK: - Services

    @State private var notificationService = NotificationService()
    @State private var networkMonitor = NetworkMonitor()

    // MARK: - Tab State

    @State private var selectedTab: Tab = .today

    enum Tab {
        case today, journey, journal, profile
    }

    // MARK: - Body

    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: $selectedTab) {

                // MARK: Today Tab
                HomeView(
                    viewModel: HomeViewModel(
                        progressService: makeProgressService(),
                        appState: appState
                    )
                )
                .tabItem {
                    Label(
                        String(localized: "tab_today"),
                        systemImage: selectedTab == .today
                            ? "circle.fill"
                            : "circle"
                    )
                }
                .tag(Tab.today)

                // MARK: Journey Tab
                JourneyView(
                    viewModel: JourneyViewModel(
                        progressService: makeProgressService(),
                        appState: appState
                    )
                )
                .tabItem {
                    Label(
                        String(localized: "tab_journey"),
                        systemImage: selectedTab == .journey
                            ? "map.fill"
                            : "map"
                    )
                }
                .tag(Tab.journey)

                // MARK: Journal Tab
                JournalView(
                    viewModel: JournalViewModel(
                        modelContext: modelContext,
                        appState: appState
                    )
                )
                .tabItem {
                    Label(
                        String(localized: "tab_journal"),
                        systemImage: selectedTab == .journal
                            ? "book.fill"
                            : "book"
                    )
                }
                .tag(Tab.journal)

                // MARK: Profile Tab
                ProfileView(
                    viewModel: ProfileViewModel(
                        progressService: makeProgressService(),
                        notificationService: notificationService,
                        appState: appState,
                        modelContext: modelContext
                    )
                )
                .tabItem {
                    Label(
                        String(localized: "tab_profile"),
                        systemImage: selectedTab == .profile
                            ? "person.fill"
                            : "person"
                    )
                }
                .tag(Tab.profile)
            }
            .tint(Color.accent)

            // MARK: Offline Banner
            if !networkMonitor.isConnected {
                OfflineBannerView()
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(1)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: networkMonitor.isConnected)
    }

    // MARK: - Factory

    private func makeProgressService() -> ProgressService {
        ProgressService(
            modelContext: modelContext,
            notificationService: notificationService
        )
    }
}

// MARK: - Preview

#Preview {
    MainTabView()
        .environment(AppState())
        .modelContainer(for: [DayProgress.self, JournalEntry.self, Achievement.self],
                        inMemory: true)
}
