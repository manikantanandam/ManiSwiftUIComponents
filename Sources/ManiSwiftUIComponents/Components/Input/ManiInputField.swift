import SwiftUI

/// Portable stand-in for `UIKeyboardType`, since UIKit types aren't safe
/// to expose from a package consumed by a Skip-transpiled target.
public enum ManiKeyboardKind: Sendable {
    case `default`
    case number
    case decimal
    case email
    case phone

    #if canImport(UIKit)
    var uiKeyboardType: UIKeyboardType {
        switch self {
        case .default: .default
        case .number: .numberPad
        case .decimal: .decimalPad
        case .email: .emailAddress
        case .phone: .phonePad
        }
    }
    #endif
}

/// Portable stand-in for `SubmitLabel` (the Return key's caption).
public enum ManiSubmitKind: Sendable {
    case done
    case next
    case go
    case search

    var submitLabel: SubmitLabel {
        switch self {
        case .done: .done
        case .next: .next
        case .go: .go
        case .search: .search
        }
    }
}

public struct ManiInputField: View {
    @Environment(\.maniTheme) private var theme
    @FocusState private var isFocused: Bool

    private let label: String
    @Binding private var text: String
    private let placeholder: String
    private let errorText: String?
    private let keyboard: ManiKeyboardKind
    private let isSecure: Bool
    private let focus: Binding<Bool>?
    private let submitKind: ManiSubmitKind
    private let onSubmit: (() -> Void)?

    /// - Parameters:
    ///   - focus: optional two-way focus binding so a parent can chain fields (Next/Done).
    ///   - submitKind: caption of the Return key.
    ///   - onSubmit: called when Return is pressed.
    public init(
        label: String,
        text: Binding<String>,
        placeholder: String = "",
        errorText: String? = nil,
        keyboard: ManiKeyboardKind = .default,
        isSecure: Bool = false,
        focus: Binding<Bool>? = nil,
        submitKind: ManiSubmitKind = .done,
        onSubmit: (() -> Void)? = nil
    ) {
        self.label = label
        self._text = text
        self.placeholder = placeholder
        self.errorText = errorText
        self.keyboard = keyboard
        self.isSecure = isSecure
        self.focus = focus
        self.submitKind = submitKind
        self.onSubmit = onSubmit
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: ManiSpacing.xs) {
            Text(label)
                .font(theme.typography.secondary)
                .foregroundStyle(theme.base.textSecondary)

            field
                .font(theme.typography.body)
                .foregroundStyle(theme.base.text)
                .focused($isFocused)
                .submitLabel(submitKind.submitLabel)
                .onSubmit { onSubmit?() }
                .onChange(of: isFocused) { _, newValue in
                    if focus?.wrappedValue != newValue { focus?.wrappedValue = newValue }
                }
                .onChange(of: focus?.wrappedValue ?? false) { _, newValue in
                    if isFocused != newValue { isFocused = newValue }
                }
                #if canImport(UIKit)
                .keyboardType(keyboard.uiKeyboardType)
                #endif
                .frame(minHeight: 52)
                .padding(.horizontal, ManiSpacing.md)
                .background(theme.base.surface)
                .clipShape(RoundedRectangle(cornerRadius: theme.radii.input, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: theme.radii.input, style: .continuous)
                        .strokeBorder(borderColor, lineWidth: isFocused ? 2 : 1)
                )

            if let errorText {
                Text(errorText)
                    .font(theme.typography.secondary)
                    .foregroundStyle(theme.base.error)
            }
        }
    }

    @ViewBuilder private var field: some View {
        if isSecure {
            SecureField(placeholder, text: $text)
        } else {
            TextField(placeholder, text: $text)
        }
    }

    private var borderColor: Color {
        if errorText != nil { return theme.base.error }
        if isFocused { return theme.accent.accent }
        return theme.base.border
    }
}
