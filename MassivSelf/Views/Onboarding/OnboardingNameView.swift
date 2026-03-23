// OnboardingNameView.swift
// Fourth onboarding screen — optional name input

import SwiftUI

struct OnboardingNameView: View {

    @Bindable var viewModel: OnboardingViewModel
    @FocusState private var isNameFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(spacing: 12) {
                Text(String(localized: "onboarding_name_title"))
                    .font(.massiveTitle)
                    .foregroundStyle(Color.primaryText)
                    .multilineTextAlignment(.center)

                Text(String(localized: "onboarding_name_subtitle"))
                    .font(.massiveBody)
                    .foregroundStyle(Color.secondaryText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }

            Spacer().frame(height: 48)

            // Name input field
            VStack(spacing: 0) {
                TextField(
                    String(localized: "onboarding_name_placeholder"),
                    text: $viewModel.userName
                )
                .font(.massiveHeadline)
                .foregroundStyle(Color.primaryText)
                .multilineTextAlignment(.center)
                .focused($isNameFocused)
                .submitLabel(.done)
                .onSubmit { viewModel.completeOnboarding() }
                .padding(.vertical, 16)
                .accessibilityLabel(String(localized: "onboarding_name_placeholder"))

                Rectangle()
                    .fill(isNameFocused ? Color.accent : Color.divider)
                    .frame(height: 1)
                    .animation(.easeInOut(duration: 0.2), value: isNameFocused)
            }
            .padding(.horizontal, 48)

            Spacer()

            // Begin button
            OnboardingPrimaryButton(
                title: String(localized: "onboarding_button_start"),
                action: { viewModel.completeOnboarding() }
            )
            .padding(.horizontal, 32)
            .padding(.bottom, 48)
        }
        .onAppear { isNameFocused = true }
        .onTapGesture { isNameFocused = false }
    }
}

#Preview {
    OnboardingNameView(
        viewModel: OnboardingViewModel(
            notificationService: NotificationService(),
            appState: AppState()
        )
    )
    .background(Color.appBackground)
}
