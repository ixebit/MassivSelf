// OnboardingContainerView.swift
// Container that manages the 4-step onboarding flow

import SwiftUI

struct OnboardingContainerView: View {

    // MARK: - Environment

    @Environment(AppState.self) private var appState
    @Environment(\.modelContext) private var modelContext

    // MARK: - ViewModel

    @State private var viewModel: OnboardingViewModel = OnboardingViewModel(
        notificationService: NotificationService(),
        appState: AppState()
    )

    // MARK: - Body

    var body: some View {
        ZStack {
            Color.appBackground
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Page indicator
                OnboardingPageIndicator(
                    currentPage: viewModel.currentPage,
                    totalPages: viewModel.totalPages
                )
                .padding(.top, 20)
                .padding(.horizontal, 32)

                // Page content
                TabView(selection: $viewModel.currentPage) {
                    OnboardingWelcomeView(viewModel: viewModel)
                        .tag(0)
                    OnboardingScienceView(viewModel: viewModel)
                        .tag(1)
                    OnboardingNotificationView(viewModel: viewModel)
                        .tag(2)
                    OnboardingNameView(viewModel: viewModel)
                        .tag(3)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut(duration: 0.35), value: viewModel.currentPage)
            }
        }
        .onAppear {
            viewModel = OnboardingViewModel(
                notificationService: NotificationService(),
                appState: appState
            )
        }
        .alert(
            String(localized: "error_title"),
            isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { if !$0 { viewModel.errorMessage = nil } }
            )
        ) {
            Button(String(localized: "button_confirm")) {
                viewModel.errorMessage = nil
            }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }
}

// MARK: - Page Indicator

private struct OnboardingPageIndicator: View {

    let currentPage: Int
    let totalPages: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalPages, id: \.self) { index in
                Capsule()
                    .fill(index == currentPage ? Color.accent : Color.stoneGray.opacity(0.3))
                    .frame(width: index == currentPage ? 24 : 8, height: 4)
                    .animation(.spring(response: 0.3), value: currentPage)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    OnboardingContainerView()
        .environment(AppState())
}
