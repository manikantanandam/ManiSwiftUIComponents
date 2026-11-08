import SwiftUI

/// A checkout payment-method row: icon + title + a toggle, revealing an amount field
/// when selected. Selecting more than one row at once is how a bill gets split across
/// payment methods — there's no separate "split" screen, it's just this row repeated.
public struct ManiPaymentModeRow: View {
    @Environment(\.maniTheme) private var theme
    private let title: String
    private let icon: ManiIconName
    private let isSelected: Bool
    @Binding private var amountText: String
    private let onToggle: (Bool) -> Void

    public init(
        title: String,
        icon: ManiIconName,
        isSelected: Bool,
        amountText: Binding<String>,
        onToggle: @escaping (Bool) -> Void
    ) {
        self.title = title
        self.icon = icon
        self.isSelected = isSelected
        self._amountText = amountText
        self.onToggle = onToggle
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: ManiSpacing.sm) {
            HStack(spacing: ManiSpacing.sm) {
                IconView(icon, size: 18, color: isSelected ? theme.base.success : theme.base.textSecondary)
                Text(title)
                    .font(theme.typography.body.weight(.medium))
                    .foregroundStyle(theme.base.text)
                Spacer()
                Toggle("", isOn: Binding(get: { isSelected }, set: onToggle))
                    .labelsHidden()
                    .tint(theme.base.success)
            }

            if isSelected {
                ManiInputField(label: "Amount", text: $amountText, placeholder: "0", keyboard: .decimal)
            }
        }
        .padding(ManiSpacing.md)
        .background(theme.base.surface)
        .clipShape(RoundedRectangle(cornerRadius: theme.radii.card, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: theme.radii.card, style: .continuous)
                .strokeBorder(isSelected ? theme.base.success : theme.base.border, lineWidth: isSelected ? 2 : 1)
        )
    }
}
