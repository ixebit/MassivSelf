// OnboardingPrimaryButton.swift
// Reusable primary CTA button used across onboarding screens

import SwiftUI

struct OnboardingPrimaryButton: View {

    let title: String
    var isLoading: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                if isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text(title)
                        .font(.massiveBody)
                        .fontWeight(.regular)
                        .tracking(1.0)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .background(Color.inkBlack)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 4))
        }
        .disabled(isLoading)
        .accessibilityLabel(title)
        .accessibilityAddTraits(.isButton)
    }
}

#Preview {
    VStack(spacing: 16) {
        OnboardingPrimaryButton(title: "Continue", action: {})
        OnboardingPrimaryButton(title: "Loading...", isLoading: true, action: {})
    }
    .padding()
    .background(Color.appBackground)
}
