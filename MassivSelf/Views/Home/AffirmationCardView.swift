// AffirmationCardView.swift
// Displays the daily affirmation in Japanese-minimal card style

import SwiftUI

struct AffirmationCardView: View {

    // MARK: - Properties

    let affirmation: String

    // MARK: - State

    @State private var isVisible = false

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            // Label
            Text(String(localized: "home_affirmation_title"))
                .font(.massiveLabel)
                .foregroundStyle(Color.secondaryText)
                .tracking(2)
                .textCase(.uppercase)

            // Affirmation text
            HStack(alignment: .top, spacing: 16) {
                // Vertical accent line
                Rectangle()
                    .fill(Color.accent.opacity(0.4))
                    .frame(width: 1)

                Text(affirmation)
                    .font(.massiveAffirmation)
                    .foregroundStyle(Color.primaryText)
                    .lineSpacing(8)
                    .fixedSize(horizontal: false, vertical: true)
                    .opacity(isVisible ? 1 : 0)
                    .offset(y: isVisible ? 0 : 8)
                    .animation(
                        .easeOut(duration: 0.6).delay(0.2),
                        value: isVisible
                    )
            }
            .padding(.leading, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear { isVisible = true }
        .onDisappear { isVisible = false }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(
            "\(String(localized: "home_affirmation_title")): \(affirmation)"
        )
    }
}

// MARK: - Preview

#Preview {
    AffirmationCardView(
        affirmation: "I am willing to see myself clearly."
    )
    .padding(24)
    .background(Color.appBackground)
}
