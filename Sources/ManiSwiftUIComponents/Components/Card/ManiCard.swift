import SwiftUI

public struct ManiCard<Content: View>: View {
    @Environment(\.maniTheme) private var theme
    private let padding: CGFloat
    private let content: Content

    public init(padding: CGFloat = ManiSpacing.md, @ViewBuilder content: () -> Content) {
        self.padding = padding
        self.content = content()
    }

    public var body: some View {
        content
            .padding(padding)
            .background(theme.base.surface)
            .clipShape(RoundedRectangle(cornerRadius: theme.radii.card, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: theme.radii.card, style: .continuous)
                    .strokeBorder(theme.base.border, lineWidth: 1)
            )
    }
}
