import SwiftUI

/// The shared base-token pair (light + dark) used by every theme, per
/// apoorva-skip's docs/04-ui-design.md. All text/background pairs here
/// meet WCAG 2.2 AA (≥4.5:1).
public enum ManiDefaultBaseTheme {
    public static let light = ManiBaseColors(
        background: maniColor(245, 246, 248),
        surface: maniColor(255, 255, 255),
        text: maniColor(15, 23, 42),
        textSecondary: maniColor(71, 85, 105),
        border: maniColor(226, 232, 240),
        success: maniColor(21, 128, 61),
        error: maniColor(185, 28, 28),
        warning: maniColor(180, 83, 9)
    )

    public static let dark = ManiBaseColors(
        background: maniColor(11, 13, 18),
        surface: maniColor(21, 25, 34),
        text: maniColor(229, 231, 235),
        textSecondary: maniColor(161, 167, 179),
        border: maniColor(38, 43, 54),
        success: maniColor(74, 222, 128),
        error: maniColor(248, 113, 113),
        warning: maniColor(251, 191, 36)
    )

    public static func colors(for scheme: ColorScheme) -> ManiBaseColors {
        scheme == .dark ? dark : light
    }
}
