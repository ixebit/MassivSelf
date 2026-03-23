// RootView.swift
// Root navigation decision — onboarding vs. main app

import SwiftUI

struct RootView: View {

    @Environment(AppState.self) private var appState

    var body: some View {
        Group {
            if appState.hasCompletedOnboarding {
                MainTabView()
            } else {
                OnboardingContainerView()
            }
        }
        .animation(.easeInOut(duration: 0.4), value: appState.hasCompletedOnboarding)
    }
}
