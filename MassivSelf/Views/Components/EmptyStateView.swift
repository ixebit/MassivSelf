// EmptyStateView.swift
// Reusable empty state component with icon, title, subtitle and optional CTA

import SwiftUI

struct EmptyStateView: View {

    // MARK: - Properties

    let icon: String
    let title: String
    let subtitle: String
    var actionTitle: String? = nil
    var action: (() -> Void)? = nil

    // MARK: - Body

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: icon)
                .font(.system(size: 40, weight: .ultraLight))
                .foregroundStyle(Color.stoneGray.opacity(0.5))
                .accessibilityHidden(true)

            VStack(spacing: 8) {
                Text(title)
                    .font(.massiveHeadline)
                    .foregroundStyle(Color.primaryText)
                    .multilineTextAlignment(.center)

                Text(subtitle)
                    .font(.massiveBody)
                    .foregroundStyle(Color.secondaryText)
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
                    .padding(.horizontal, 32)
            }

            if let actionTitle, let action {
                Button(action: action) {
                    Text(actionTitle)
                        .font(.massiveBody)
                        .foregroundStyle(Color.accent)
                        .frame(height: 44)
                }
                .accessibilityLabel(actionTitle)
                .accessibilityAddTraits(.isButton)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .combine)
    }
}

// MARK: - Preview

#Preview {
    EmptyStateView(
        icon: "book",
        title: "No entries yet",
        subtitle: "Your reflections will appear here after you complete daily tasks.",
        actionTitle: "Go to Today",
        action: {}
    )
    .background(Color.appBackground)
}
