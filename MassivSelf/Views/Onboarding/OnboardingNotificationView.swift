// OnboardingNotificationView.swift
// Third onboarding screen — notification permission request

import SwiftUI

struct OnboardingNotificationView: View {

    @Bindable var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // Bell icon
            ZStack {
                Circle()
                    .fill(Color.accent.opacity(0.08))
                    .frame(width: 120, height: 120)
                Image(systemName: "bell.badge")
                    .font(.system(size: 48, weight: .ultraLight))
                    .foregroundStyle(Color.accent)
            }
            .accessibilityHidden(true)

            Spacer().frame(height: 40)

            VStack(spacing: 12) {
                Text(String(localized: "onboarding_notification_title"))
                    .font(.massiveTitle)
                    .foregroundStyle(Color.primaryText)
                    .multilineTextAlignment(.center)

                Text(String(localized: "onboarding_notification_subtitle"))
                    .font(.massiveBody)
                    .foregroundStyle(Color.secondaryText)
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                    .padding(.horizontal, 40)
            }

            Spacer()

            VStack(spacing: 12) {
                // Allow button
                OnboardingPrimaryButton(
                    title: String(localized: "onboarding_button_allow_notifications"),
                    isLoading: viewModel.isRequestingNotifications,
                    action: {
                        Task { await viewModel.requestNotifications() }
                    }
                )

                // Skip button
                Button(String(localized: "onboarding_button_skip")) {
                    viewModel.skip()
                }
                .font(.massiveBody)
                .foregroundStyle(Color.secondaryText)
                .frame(height: 44)
                .accessibilityLabel(String(localized: "onboarding_button_skip"))
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 48)
        }
    }
}

#Preview {
    OnboardingNotificationView(
        viewModel: OnboardingViewModel(
            notificationService: NotificationService(),
            appState: AppState()
        )
    )
    .background(Color.appBackground)
}
