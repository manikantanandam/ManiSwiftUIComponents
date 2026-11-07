import SwiftUI

public struct ManiKPITile: View {
    @Environment(\.maniTheme) private var theme
    private let title: String
    private let value: String
    private let isHighlighted: Bool

    public init(title: String, value: String, isHighlighted: Bool = false) {
        self.title = title
        self.value = value
        self.isHighlighted = isHighlighted
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: ManiSpacing.xs) {
            Text(title)
                .font(theme.typography.secondary)
                .foregroundStyle(isHighlighted ? highlightedForeground.opacity(0.85) : theme.base.textSecondary)
            Text(value)
                .font(theme.typography.kpiValue)
                .foregroundStyle(isHighlighted ? highlightedForeground : theme.base.text)
        }
        .padding(ManiSpacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(background)
        .clipShape(RoundedRectangle(cornerRadius: theme.radii.card, style: .continuous))
    }

    private var background: Color {
        guard isHighlighted else { return theme.base.surface }
        return theme.style == .bold ? theme.accent.accent : theme.accent.soft
    }

    private var highlightedForeground: Color {
        theme.style == .bold ? theme.accent.on : theme.base.text
    }
}
