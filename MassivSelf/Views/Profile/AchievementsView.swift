// AchievementsView.swift
// Grid of all achievements — locked and unlocked

import SwiftUI

struct AchievementsGridView: View {

    let achievements: [Achievement]

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(AchievementType.allCases, id: \.self) { type in
                let achievement = achievements.first { $0.type == type }
                let isUnlocked = achievement?.isUnlocked ?? false

                AchievementCell(
                    type: type,
                    isUnlocked: isUnlocked,
                    unlockedAt: achievement?.unlockedAt
                )
            }
        }
    }
}

// MARK: - Achievement Cell

private struct AchievementCell: View {

    let type: AchievementType
    let isUnlocked: Bool
    let unlockedAt: Date?

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(isUnlocked
                        ? Color.accent.opacity(0.1)
                        : Color.cardBackground
                    )
                    .frame(width: 52, height: 52)
                    .overlay(
                        Circle()
                            .stroke(
                                isUnlocked
                                    ? Color.accent.opacity(0.3)
                                    : Color.divider,
                                lineWidth: 0.5
                            )
                    )

                Image(systemName: type.sfSymbol)
                    .font(.system(size: 20, weight: .ultraLight))
                    .foregroundStyle(
                        isUnlocked
                            ? Color.accent
                            : Color.stoneGray.opacity(0.3)
                    )
            }

            Text(String(localized: String.LocalizationValue(type.titleKey)))
                .font(.massiveLabel)
                .foregroundStyle(
                    isUnlocked ? Color.primaryText : Color.stoneGray.opacity(0.4)
                )
                .tracking(0.5)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .opacity(isUnlocked ? 1.0 : 0.6)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(
            "\(String(localized: String.LocalizationValue(type.titleKey))): \(isUnlocked ? "unlocked" : "locked")"
        )
    }
}

// MARK: - Preview

#Preview {
    AchievementsGridView(achievements: [])
        .padding(24)
        .background(Color.appBackground)
}
