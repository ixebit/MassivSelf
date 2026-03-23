// Font+MassiveSelf.swift
// Typography system — Japanese-inspired with generous spacing

import SwiftUI

extension Font {

    // MARK: - Display

    /// Large title — used for day numbers and hero text
    static let massiveDisplay: Font = .system(
        size: 56,
        weight: .ultraLight,
        design: .default
    )

    /// Section title
    static let massiveTitle: Font = .system(
        size: 28,
        weight: .light,
        design: .default
    )

    /// Card title
    static let massiveHeadline: Font = .system(
        size: 20,
        weight: .regular,
        design: .default
    )

    // MARK: - Body

    /// Primary body text
    static let massiveBody: Font = .system(
        size: 16,
        weight: .light,
        design: .default
    )

    /// Secondary / caption text
    static let massiveCaption: Font = .system(
        size: 13,
        weight: .light,
        design: .default
    )

    // MARK: - Special

    /// Module label — small caps feel
    static let massiveLabel: Font = .system(
        size: 11,
        weight: .medium,
        design: .default
    )

    /// Affirmation text — slightly italic feel
    static let massiveAffirmation: Font = .system(
        size: 18,
        weight: .light,
        design: .serif
    )
}
