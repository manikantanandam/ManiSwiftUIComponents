import SwiftUI

public struct ManiChip: View {
    @Environment(\.maniTheme) private var theme

    private let title: String
    private let icon: ManiIconName?
    private let isSelected: Bool
    private let action: () -> Void

    public init(_ title: String, icon: ManiIconName? = nil, isSelected: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.isSelected = isSelected
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: ManiSpacing.xs) {
                if let icon {
                    IconView(icon, size: 14, color: foreground)
                }
                Text(title)
                    .font(theme.typography.secondary.weight(isSelected ? .semibold : .regular))
                    .foregroundStyle(foreground)
            }
            .padding(.horizontal, ManiSpacing.md)
            .frame(minHeight: 32)
        }
        .background(background)
        .clipShape(RoundedRectangle(cornerRadius: theme.radii.chip, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: theme.radii.chip, style: .continuous)
                .strokeBorder(isSelected ? theme.accent.accent : theme.base.border, lineWidth: 1)
        )
    }

    private var background: Color {
        guard isSelected else { return theme.base.surface }
        return theme.style == .bold ? theme.accent.accent : theme.accent.soft
    }

    private var foreground: Color {
        guard isSelected else { return theme.base.text }
        return theme.style == .bold ? theme.accent.on : theme.accent.accent
    }
}
