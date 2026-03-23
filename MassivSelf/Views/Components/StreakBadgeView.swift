// StreakBadgeView.swift
// Displays the current streak count with a flame icon

import SwiftUI

struct StreakBadgeView: View {

    let streakCount: Int

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "flame.fill")
                .font(.system(size: 12, weight: .light))
                .foregroundStyle(Color.accent)

            Text("\(streakCount)")
                .font(.massiveLabel)
                .foregroundStyle(Color.primaryText)
                .tracking(1)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(Color.cardBackground)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(Color.divider, lineWidth: 0.5)
        )
        .accessibilityLabel("\(streakCount) day streak")
    }
}

#Preview {
    HStack(spacing: 16) {
        StreakBadgeView(streakCount: 0)
        StreakBadgeView(streakCount: 7)
        StreakBadgeView(streakCount: 30)
    }
    .padding()
    .background(Color.appBackground)
}
