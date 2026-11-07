import SwiftUI

public struct ManiSearchField: View {
    @Environment(\.maniTheme) private var theme
    @Binding private var text: String
    private let placeholder: String

    public init(text: Binding<String>, placeholder: String = "Search") {
        self._text = text
        self.placeholder = placeholder
    }

    public var body: some View {
        HStack(spacing: ManiSpacing.sm) {
            IconView(.search, size: 16, color: theme.base.textSecondary)
            TextField(placeholder, text: $text)
                .font(theme.typography.body)
                .foregroundStyle(theme.base.text)
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    IconView(.close, size: 14, color: theme.base.textSecondary)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, ManiSpacing.md)
        .frame(minHeight: 44)
        .background(theme.base.surface)
        .clipShape(RoundedRectangle(cornerRadius: theme.radii.input, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: theme.radii.input, style: .continuous)
                .strokeBorder(theme.base.border, lineWidth: 1)
        )
    }
}
