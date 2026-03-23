// MoodCheckInView.swift
// 5-point mood rating selector with emoji-style SF Symbol indicators

import SwiftUI

struct MoodCheckInView: View {

    // MARK: - Properties

    let selectedMood: Int
    let onMoodSelected: (Int) -> Void

    // MARK: - Mood Data

    private let moods: [(symbol: String, label: String)] = [
        ("cloud.rain",      "mood_1"),
        ("cloud",           "mood_2"),
        ("sun.min",         "mood_3"),
        ("sun.max",         "mood_4"),
        ("sun.max.fill",    "mood_5")
    ]

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(String(localized: "home_mood_title"))
                .font(.massiveLabel)
                .foregroundStyle(Color.secondaryText)
                .tracking(2)
                .textCase(.uppercase)

            HStack(spacing: 0) {
                ForEach(Array(moods.enumerated()), id: \.offset) { index, mood in
                    let rating = index + 1
                    let isSelected = selectedMood == rating

                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            onMoodSelected(rating)
                        }
                    } label: {
                        VStack(spacing: 6) {
                            Image(systemName: mood.symbol)
                                .font(.system(
                                    size: isSelected ? 26 : 22,
                                    weight: .ultraLight
                                ))
                                .foregroundStyle(
                                    isSelected ? Color.accent : Color.stoneGray.opacity(0.5)
                                )
                                .scaleEffect(isSelected ? 1.1 : 1.0)
                                .animation(
                                    .spring(response: 0.3, dampingFraction: 0.6),
                                    value: isSelected
                                )

                            if isSelected {
                                Circle()
                                    .fill(Color.accent)
                                    .frame(width: 4, height: 4)
                                    .transition(.scale.combined(with: .opacity))
                            } else {
                                Circle()
                                    .fill(Color.clear)
                                    .frame(width: 4, height: 4)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(String(localized:
                        String.LocalizationValue(mood.label)))
                    .accessibilityAddTraits(isSelected ? [.isSelected] : [])
                    .sensoryFeedback(.selection, trigger: isSelected)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 32) {
        MoodCheckInView(selectedMood: 0, onMoodSelected: { _ in })
        MoodCheckInView(selectedMood: 3, onMoodSelected: { _ in })
        MoodCheckInView(selectedMood: 5, onMoodSelected: { _ in })
    }
    .padding(24)
    .background(Color.appBackground)
}
