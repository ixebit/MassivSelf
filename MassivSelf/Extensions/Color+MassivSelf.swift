// Color+MassiveSelf.swift
// Japanese-inspired color palette for the app

import SwiftUI

extension Color {

    // MARK: - Brand Colors

    /// Primary ink black — used for headings and primary text
    static let inkBlack = Color("InkBlack")

    /// Warm off-white — used for backgrounds (washi paper feel)
    static let washiWhite = Color("WashiWhite")

    /// Accent cherry red — used sparingly for CTAs and highlights
    static let cherryRed = Color("CherryRed")

    /// Stone gray — used for secondary text and dividers
    static let stoneGray = Color("StoneGray")

    /// Soft moss green — used for completed states
    static let mossGreen = Color("MossGreen")

    /// Deep indigo — used for module 3 (Mind) accent
    static let deepIndigo = Color("DeepIndigo")

    // MARK: - Semantic Aliases

    static let appBackground = Color("AppBackground")
    static let cardBackground = Color("CardBackground")
    static let primaryText = Color("PrimaryText")
    static let secondaryText = Color("SecondaryText")
    static let divider = Color("Divider")
    static let accent = Color.cherryRed
}
