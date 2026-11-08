import SwiftUI

/// A tap-target grid tile for picking a POS category/item — unlike `ManiItemTile`,
/// tapping it doesn't step a quantity in place; it's meant to open a detail/price
/// screen, so there's no +/- affordance here.
public struct ManiCategoryTile: View {
    @Environment(\.maniTheme) private var theme
    private let title: String
    private let isHotkey: Bool
    private let action: () -> Void

    public init(title: String, isHotkey: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.isHotkey = isHotkey
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(spacing: 0) {
                if isHotkey {
                    RoundedRectangle(cornerRadius: 2, style: .continuous)
                        .fill(theme.accent.accent)
                        .frame(height: 3)
                        .padding(.bottom, ManiSpacing.sm)
                }
                Text(title)
                    .font(theme.typography.body.weight(.medium))
                    .foregroundStyle(theme.base.text)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity)
            }
            .padding(ManiSpacing.sm)
            .frame(minHeight: 72)
        }
        .buttonStyle(.plain)
        .background(theme.base.surface)
        .clipShape(RoundedRectangle(cornerRadius: theme.radii.card, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: theme.radii.card, style: .continuous)
                .strokeBorder(theme.base.border, lineWidth: 1)
        )
    }
}
