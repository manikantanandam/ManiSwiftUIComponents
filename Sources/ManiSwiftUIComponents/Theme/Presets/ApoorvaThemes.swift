import SwiftUI

/// A theme defined purely by a light/dark accent pair, using the shared
/// `ManiDefaultBaseTheme` for everything else. These five mirror apoorva-skip's
/// vertical accents and ship as example presets — nothing in this package is
/// hardcoded to them; a consumer can define its own `ManiTheme` the same way.
public struct ManiAccentTheme: ManiTheme {
    public let name: String
    private let lightAccent: ManiAccentColors
    private let darkAccent: ManiAccentColors

    public init(name: String, lightAccent: ManiAccentColors, darkAccent: ManiAccentColors) {
        self.name = name
        self.lightAccent = lightAccent
        self.darkAccent = darkAccent
    }

    public func accentColors(for scheme: ColorScheme) -> ManiAccentColors {
        scheme == .dark ? darkAccent : lightAccent
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
}
