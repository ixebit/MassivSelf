// OnboardingWelcomeView.swift
// First onboarding screen — app name, philosophy, CTA

import SwiftUI

struct OnboardingWelcomeView: View {

    // MARK: - Properties

    @Bindable var viewModel: OnboardingViewModel

    // MARK: - Body

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // Japanese character decoration
            Text("自信")
                .font(.system(size: 96, weight: .ultraLight))
                .foregroundStyle(Color.accent.opacity(0.15))
                .accessibilityHidden(true)

            Spacer().frame(height: 32)

            // App title
            VStack(spacing: 12) {
                Text("MassivSelf")
                    .font(.massiveDisplay)
                    .foregroundStyle(Color.primaryText)
                    .tracking(4)

                Text(String(localized: "onboarding_welcome_title"))
                    .font(.massiveHeadline)
                    .foregroundStyle(Color.primaryText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                Spacer().frame(height: 16)

                Text(String(localized: "onboarding_welcome_subtitle"))
                    .font(.massiveBody)
                    .foregroundStyle(Color.secondaryText)
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                    .padding(.horizontal, 40)
            }

            Spacer()

            // Thin divider — Japanese aesthetic
            Rectangle()
                .fill(Color.divider)
                .frame(height: 0.5)
                .padding(.horizontal, 48)
                .padding(.bottom, 40)

            // CTA Button
            OnboardingPrimaryButton(
                title: String(localized: "onboarding_button_next"),
                action: { viewModel.advance() }
            )
            .padding(.horizontal, 32)
            .padding(.bottom, 48)
        }
        .accessibilityElement(children: .contain)
    }
}

// MARK: - Preview

#Preview {
    OnboardingWelcomeView(
        viewModel: OnboardingViewModel(
            notificationService: NotificationService(),
            appState: AppState()
        )
    )
    .background(Color.appBackground)
}
