// JapaneseCardView.swift
// Reusable card container with Japanese-minimal styling

import SwiftUI

struct JapaneseCardView<Content: View>: View {

    // MARK: - Properties

    var accentColor: Color = .accent
    var showLeftBorder: Bool = true
    @ViewBuilder let content: () -> Content

    // MARK: - Body

    var body: some View {
        ZStack(alignment: .leading) {
            // Card background
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.cardBackground)

            // Left accent border
            if showLeftBorder {
                Rectangle()
                    .fill(accentColor)
                    .frame(width: 2)
                    .clipShape(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 2,
                            bottomLeadingRadius: 2
                        )
                    )
            }

            // Content
            content()
                .padding(.leading, showLeftBorder ? 20 : 16)
                .padding(.trailing, 16)
                .padding(.vertical, 16)
        }
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 16) {
        JapaneseCardView {
            VStack(alignment: .leading, spacing: 8) {
                Text("Card Title")
                    .font(.massiveHeadline)
                    .foregroundStyle(Color.primaryText)
                Text("Card subtitle or description text goes here.")
                    .font(.massiveBody)
                    .foregroundStyle(Color.secondaryText)
            }
        }

        JapaneseCardView(accentColor: .mossGreen) {
            Text("Completed state card")
                .font(.massiveBody)
                .foregroundStyle(Color.primaryText)
        }
    }
    .padding(24)
    .background(Color.appBackground)
}
