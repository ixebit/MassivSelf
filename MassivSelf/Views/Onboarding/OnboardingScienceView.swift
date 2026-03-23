// OnboardingScienceView.swift
// Second onboarding screen — scientific foundations

import SwiftUI

struct OnboardingScienceView: View {

    @Bindable var viewModel: OnboardingViewModel

    // MARK: - Science pillars data

    private let pillars: [(icon: String, titleKey: String, descKey: String)] = [
        ("brain.head.profile", "science_cbt_title", "science_cbt_desc"),
        ("figure.walk", "science_bandura_title", "science_bandura_desc"),
        ("leaf", "science_act_title", "science_act_desc"),
        ("sun.max", "science_positive_title", "science_positive_desc")
    ]

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(spacing: 8) {
                Text(String(localized: "onboarding_science_title"))
                    .font(.massiveTitle)
                    .foregroundStyle(Color.primaryText)
                    .multilineTextAlignment(.center)

                Text(String(localized: "onboarding_science_subtitle"))
                    .font(.massiveBody)
                    .foregroundStyle(Color.secondaryText)
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
                    .padding(.horizontal, 32)
            }

            Spacer().frame(height: 40)

            // Science pillars
            VStack(spacing: 0) {
                ForEach(Array(pillars.enumerated()), id: \.offset) { index, pillar in
                    SciencePillarRow(
                        icon: pillar.icon,
                        title: String(localized: String.LocalizationValue(pillar.titleKey)),
                        description: String(localized:
                            String.LocalizationValue(pillar.descKey))
                    )
                    if index < pillars.count - 1 {
                        Divider()
                            .padding(.leading, 56)
                    }
                }
            }
            .padding(.horizontal, 24)
            .background(Color.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal, 24)

            Spacer()

            OnboardingPrimaryButton(
                title: String(localized: "onboarding_button_next"),
                action: { viewModel.advance() }
            )
            .padding(.horizontal, 32)
            .padding(.bottom, 48)
        }
    }
}

// MARK: - Science Pillar Row

private struct SciencePillarRow: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .light))
                .foregroundStyle(Color.accent)
                .frame(width: 28)
                .padding(.top, 2)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.massiveHeadline)
                    .foregroundStyle(Color.primaryText)
                Text(description)
                    .font(.massiveCaption)
                    .foregroundStyle(Color.secondaryText)
                    .lineSpacing(4)
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    OnboardingScienceView(
        viewModel: OnboardingViewModel(
            notificationService: NotificationService(),
            appState: AppState()
        )
    )
    .background(Color.appBackground)
}
