import SwiftUI

/// The "CartBar" from the spec — a floating bar above the tab bar, e.g.
/// checkout's "Collect ₹583" / "Hold bill".
public struct ManiActionBar: View {
    @Environment(\.maniTheme) private var theme
    private let summaryText: String?
    private let primaryTitle: String
    private let primaryAction: () -> Void
    private let secondaryTitle: String?
    private let secondaryAction: (() -> Void)?

    public init(
        summaryText: String? = nil,
        primaryTitle: String,
        primaryAction: @escaping () -> Void,
        secondaryTitle: String? = nil,
        secondaryAction: (() -> Void)? = nil
    ) {
        self.summaryText = summaryText
        self.primaryTitle = primaryTitle
        self.primaryAction = primaryAction
        self.secondaryTitle = secondaryTitle
        self.secondaryAction = secondaryAction
    }

    public var body: some View {
        VStack(spacing: ManiSpacing.sm) {
            if let summaryText {
                Text(summaryText)
                    .font(theme.typography.secondary)
                    .foregroundStyle(theme.base.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: ManiSpacing.sm) {
                if let secondaryTitle, let secondaryAction {
                    ManiButton(secondaryTitle, kind: .outline, action: secondaryAction)
                }
                ManiButton(primaryTitle, kind: .primary, action: primaryAction)
            }
        }
        .padding(ManiSpacing.md)
        .background(theme.base.surface)
        .clipShape(RoundedRectangle(cornerRadius: theme.radii.sheet, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: theme.radii.sheet, style: .continuous)
                .strokeBorder(theme.base.border, lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.08), radius: 12, y: -2)
    }
}
