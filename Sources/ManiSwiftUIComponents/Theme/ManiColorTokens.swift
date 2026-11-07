import SwiftUI

/// Base semantic colors shared by every theme, resolved per color scheme.
/// Values must only ever be built from `Color(red:green:blue:)` literals —
/// never `UIColor`/`Color(uiColor:)` — so this stays portable to non-UIKit
/// targets (e.g. Skip's Android transpilation).
public struct ManiBaseColors: Sendable {
    public let background: Color
    public let surface: Color
    public let text: Color
    public let textSecondary: Color
    public let border: Color
    public let success: Color
    public let error: Color
    public let warning: Color

    public init(
        background: Color,
        surface: Color,
        text: Color,
        textSecondary: Color,
        border: Color,
        success: Color,
        error: Color,
        warning: Color
    ) {
        self.background = background
        self.surface = surface
        self.text = text
        self.textSecondary = textSecondary
        self.border = border
        self.success = success
        self.error = error
        self.warning = warning
    }
}

/// An accent color and the two values derived from it.
public struct ManiAccentColors: Sendable {
    /// The primary brand/vertical accent color.
    public let accent: Color
    /// Accent at low opacity, used for selected-chip tints, the first
    /// highlighted KPI tile, avatar backgrounds, and note backgrounds.
    public let soft: Color
    /// A contrast-safe text/icon color to place on top of a solid `accent` fill.
    public let on: Color

    /// - Parameter on: must be chosen for ≥4.5:1 contrast against `accent`;
    ///   opacity math alone cannot guarantee that, so it is always explicit.
    public init(accent: Color, on: Color) {
        self.accent = accent
        self.soft = accent.opacity(0.13)
        self.on = on
    }
}

func maniColor(_ red: Int, _ green: Int, _ blue: Int) -> Color {
    Color(red: Double(red) / 255, green: Double(green) / 255, blue: Double(blue) / 255)
}
