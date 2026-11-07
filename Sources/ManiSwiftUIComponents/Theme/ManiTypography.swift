import SwiftUI

/// Type roles, varying by `ManiStyle`. Font family override is an unused
/// seam for a future org-selectable font feature (downloaded/cached by the
/// consuming app) — this package only ever uses `Font.system`.
public struct ManiTypography: Sendable {
    public let screenTitle: Font
    public let sectionHeader: Font
    public let body: Font
    public let secondary: Font
    public let kpiValue: Font
    public let heroValue: Font

    /// Reserved for a future consumer-supplied font family; unused in v1.
    public let fontFamilyOverride: String?

    public init(style: ManiStyle, fontFamilyOverride: String? = nil) {
        self.fontFamilyOverride = fontFamilyOverride
        switch style {
        case .clean:
            screenTitle = .system(size: 22, weight: .semibold)
            sectionHeader = .system(size: 15, weight: .semibold)
            body = .system(size: 15, weight: .regular)
            secondary = .system(size: 13, weight: .regular)
            kpiValue = .system(size: 22, weight: .semibold).monospacedDigit()
            heroValue = .system(size: 36, weight: .semibold).monospacedDigit()
        case .bold:
            screenTitle = .system(size: 22, weight: .bold)
            sectionHeader = .system(size: 13, weight: .semibold)
            body = .system(size: 13.5, weight: .semibold)
            secondary = .system(size: 11.5, weight: .regular)
            kpiValue = .system(size: 22, weight: .bold).monospacedDigit()
            heroValue = .system(size: 36, weight: .bold).monospacedDigit()
        }
    }
}
