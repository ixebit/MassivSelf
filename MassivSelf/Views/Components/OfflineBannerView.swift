// OfflineBannerView.swift
// Shown at top of screen when device is offline

import SwiftUI

struct OfflineBannerView: View {

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "wifi.slash")
                .font(.system(size: 12, weight: .medium))

            Text(String(localized: "offline_banner"))
                .font(.massiveCaption)
                .lineLimit(1)
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(Color.inkBlack.opacity(0.85))
        .accessibilityLabel(String(localized: "offline_banner"))
    }
}

// MARK: - Preview

#Preview {
    VStack {
        OfflineBannerView()
        Spacer()
    }
    .background(Color.appBackground)
}
