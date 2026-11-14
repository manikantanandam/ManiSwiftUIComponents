import SwiftUI

public struct ManiSearchField: View {
    @Environment(\.maniTheme) private var theme
    @Binding private var text: String
    private let placeholder: String
    private let focus: Binding<Bool>?
    @FocusState private var isFocused: Bool

    /// - Parameter focus: optional two-way focus binding so a parent can react to / drive focus.
    public init(text: Binding<String>, placeholder: String = "Search", focus: Binding<Bool>? = nil) {
        self._text = text
        self.placeholder = placeholder
        self.focus = focus
    }

    public var body: some View {
        HStack(spacing: ManiSpacing.sm) {
            IconView(.search, size: 16, color: theme.base.textSecondary)
            TextField(placeholder, text: $text)
                .font(theme.typography.body)
                .foregroundStyle(theme.base.text)
                .focused($isFocused)
                .onChange(of: isFocused) { _, newValue in
                    if focus?.wrappedValue != newValue { focus?.wrappedValue = newValue }
                }
                .onChange(of: focus?.wrappedValue ?? false) { _, newValue in
                    if isFocused != newValue { isFocused = newValue }
                }
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
