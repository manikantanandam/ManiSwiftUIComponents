import SwiftUI

/// A theme supplies an accent color pair; base colors default to the shared
/// `ManiDefaultBaseTheme` so most themes only need to implement
/// `accentColors(for:)`. This package does not implement org/store/user
/// theme-resolution logic — that policy belongs in the consuming app, which
/// picks a `ManiTheme` + `ManiStyle` and injects them with `.maniTheme(...)`.
public protocol ManiTheme: Sendable {
    var name: String { get }
    func baseColors(for scheme: ColorScheme) -> ManiBaseColors
    func accentColors(for scheme: ColorScheme) -> ManiAccentColors
}

public extension ManiTheme {
    func baseColors(for scheme: ColorScheme) -> ManiBaseColors {
        ManiDefaultBaseTheme.colors(for: scheme)
    }
}

/// The fully-resolved bundle every component reads from the environment.
public struct ManiThemeContext: Sendable {
    public let base: ManiBaseColors
    public let accent: ManiAccentColors
    public let style: ManiStyle
    public let radii: ManiRadii
    public let typography: ManiTypography

    public init(base: ManiBaseColors, accent: ManiAccentColors, style: ManiStyle, radii: ManiRadii, typography: ManiTypography) {
        self.base = base
        self.accent = accent
        self.style = style
        self.radii = radii
        self.typography = typography
    }

    public static func resolve(theme: any ManiTheme, style: ManiStyle, scheme: ColorScheme) -> ManiThemeContext {
        ManiThemeContext(
            base: theme.baseColors(for: scheme),
            accent: theme.accentColors(for: scheme),
            style: style,
            radii: ManiRadii(style: style),
            typography: ManiTypography(style: style)
        )
    }

    /// Fallback used only when no `.maniTheme(...)` was applied up the view tree.
    public static let fallback = ManiThemeContext.resolve(theme: ManiAccentTheme.apoorvaInk, style: .clean, scheme: .light)
}
