import SwiftUI

/// A theme defined purely by a light/dark accent pair, using the shared
/// `ManiDefaultBaseTheme` for everything else. These five mirror apoorva-skip's
/// vertical accents and ship as example presets — nothing in this package is
/// hardcoded to them; a consumer can define its own `ManiTheme` the same way.
public struct ManiAccentTheme: ManiTheme {
    public let name: String
    private let lightAccent: ManiAccentColors
    private let darkAccent: ManiAccentColors
    private let lightBase: ManiBaseColors?
    private let darkBase: ManiBaseColors?

    /// `lightBase`/`darkBase` override the shared base colors, e.g. Bold verticals that tint the background.
    public init(name: String,
                lightAccent: ManiAccentColors,
                darkAccent: ManiAccentColors,
                lightBase: ManiBaseColors? = nil,
                darkBase: ManiBaseColors? = nil) {
        self.name = name
        self.lightAccent = lightAccent
        self.darkAccent = darkAccent
        self.lightBase = lightBase
        self.darkBase = darkBase
    }

    public func accentColors(for scheme: ColorScheme) -> ManiAccentColors {
        scheme == .dark ? darkAccent : lightAccent
    }

    public func baseColors(for scheme: ColorScheme) -> ManiBaseColors {
        let override = scheme == .dark ? darkBase : lightBase
        return override ?? ManiDefaultBaseTheme.colors(for: scheme)
    }
}

public extension ManiBaseColors {
    /// Copy with a different background/surface/border, keeping text and status colors.
    func tinted(background: Color? = nil, surface: Color? = nil, border: Color? = nil) -> ManiBaseColors {
        ManiBaseColors(background: background ?? self.background,
                       surface: surface ?? self.surface,
                       text: text,
                       textSecondary: textSecondary,
                       border: border ?? self.border,
                       success: success,
                       error: error,
                       warning: warning)
    }
}

/// Dark-mode accents in this spec are light pastels used on dark surfaces;
/// a dark "on" text color is a pragmatic default pending per-theme contrast
/// QA, not a computed guarantee.
private let onDark = maniColor(15, 23, 42)
private let onLight = Color.white

/// Declared as a `Self ==`-constrained protocol extension (rather than a
/// plain extension on `ManiAccentTheme`) so leading-dot syntax works at
/// `any ManiTheme`/generic `ManiTheme` call sites, e.g. `.maniTheme(.apoorvaInk)`.
public extension ManiTheme where Self == ManiAccentTheme {
    static var apoorvaInk: ManiAccentTheme {
        ManiAccentTheme(
            name: "Apoorva Ink",
            lightAccent: ManiAccentColors(accent: maniColor(63, 67, 150), on: onLight),
            darkAccent: ManiAccentColors(accent: maniColor(165, 180, 252), on: onDark)
        )
    }

    static var kiranaSage: ManiAccentTheme {
        ManiAccentTheme(
            name: "Kirana Sage",
            lightAccent: ManiAccentColors(accent: maniColor(47, 111, 98), on: onLight),
            darkAccent: ManiAccentColors(accent: maniColor(94, 196, 174), on: onDark)
        )
    }

    static var fancyPlum: ManiAccentTheme {
        ManiAccentTheme(
            name: "Fancy Plum",
            lightAccent: ManiAccentColors(accent: maniColor(138, 63, 134), on: onLight),
            darkAccent: ManiAccentColors(accent: maniColor(224, 168, 220), on: onDark)
        )
    }

    static var jewelleryBrass: ManiAccentTheme {
        ManiAccentTheme(
            name: "Jewellery Brass",
            lightAccent: ManiAccentColors(accent: maniColor(133, 103, 44), on: onLight),
            darkAccent: ManiAccentColors(accent: maniColor(217, 190, 133), on: onDark)
        )
    }

    static var parlourRose: ManiAccentTheme {
        ManiAccentTheme(
            name: "Parlour Rose",
            lightAccent: ManiAccentColors(accent: maniColor(163, 64, 92), on: onLight),
            darkAccent: ManiAccentColors(accent: maniColor(240, 163, 184), on: onDark)
        )
    }

    // MARK: - Bold palette
    // The Bold style uses saturated accents and, for some verticals, a tinted background
    // (designs/_src/generate.py `THEMES`). Pair these with `style: .bold`.

    static var boldIndigo: ManiAccentTheme {
        ManiAccentTheme(
            name: "Apoorva Indigo",
            lightAccent: ManiAccentColors(accent: maniColor(79, 70, 229), on: onLight),
            darkAccent: ManiAccentColors(accent: maniColor(165, 180, 252), on: onDark)
        )
    }

    static var boldTeal: ManiAccentTheme {
        ManiAccentTheme(
            name: "Fresh Teal",
            lightAccent: ManiAccentColors(accent: maniColor(15, 118, 110), on: onLight),
            darkAccent: ManiAccentColors(accent: maniColor(45, 212, 191), on: onDark),
            lightBase: ManiDefaultBaseTheme.colors(for: .light).tinted(background: maniColor(244, 248, 247))
        )
    }

    static var boldOrchid: ManiAccentTheme {
        ManiAccentTheme(
            name: "Orchid",
            lightAccent: ManiAccentColors(accent: maniColor(192, 38, 211), on: onLight),
            darkAccent: ManiAccentColors(accent: maniColor(232, 121, 249), on: onDark),
            lightBase: ManiDefaultBaseTheme.colors(for: .light).tinted(background: maniColor(249, 246, 251))
        )
    }

    static var boldGold: ManiAccentTheme {
        ManiAccentTheme(
            name: "Antique Gold",
            lightAccent: ManiAccentColors(accent: maniColor(161, 98, 7), on: onLight),
            darkAccent: ManiAccentColors(accent: maniColor(226, 184, 101), on: onDark),
            lightBase: ManiDefaultBaseTheme.colors(for: .light).tinted(background: maniColor(250, 247, 241)),
            darkBase: ManiDefaultBaseTheme.colors(for: .dark).tinted(background: maniColor(18, 16, 12),
                                                                    surface: maniColor(28, 25, 19),
                                                                    border: maniColor(46, 41, 32))
        )
    }

    static var boldRose: ManiAccentTheme {
        ManiAccentTheme(
            name: "Rose",
            lightAccent: ManiAccentColors(accent: maniColor(190, 24, 93), on: onLight),
            darkAccent: ManiAccentColors(accent: maniColor(249, 168, 212), on: onDark),
            lightBase: ManiDefaultBaseTheme.colors(for: .light).tinted(background: maniColor(251, 246, 248))
        )
    }
}
