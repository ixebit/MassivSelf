// ProgressRingView.swift
// Circular progress ring used in profile and journey screens

import SwiftUI

struct ProgressRingView: View {

    // MARK: - Properties

    let progress: Double        // 0.0 – 1.0
    let size: CGFloat
    let lineWidth: CGFloat
    var showLabel: Bool = true

    // MARK: - Body

    var body: some View {
        ZStack {
            // Background ring
            Circle()
                .stroke(Color.divider, lineWidth: lineWidth)
                .frame(width: size, height: size)

            // Progress ring
            Circle()
                .trim(from: 0, to: min(progress, 1.0))
                .stroke(
                    Color.accent,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .frame(width: size, height: size)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 1.0), value: progress)

            // Center label
            if showLabel {
                Text("\(Int(progress * 100))%")
                    .font(.system(
                        size: size * 0.18,
                        weight: .light,
                        design: .default
                    ))
                    .foregroundStyle(Color.primaryText)
            }
        }
        .accessibilityLabel(
            String(format: String(localized: "accessibility_progress_percent"),
                   Int(progress * 100))
        )
    }
}

// MARK: - Preview

#Preview {
    HStack(spacing: 32) {
        ProgressRingView(progress: 0.0, size: 80, lineWidth: 2)
        ProgressRingView(progress: 0.5, size: 80, lineWidth: 2)
        ProgressRingView(progress: 1.0, size: 80, lineWidth: 2)
    }
    .padding()
    .background(Color.appBackground)
}
