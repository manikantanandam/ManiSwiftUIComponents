import SwiftUI

/// A POS cart line item: title/subtitle on the left, total + "qty × unit price" on the
/// right, and a remove affordance — distinct from `ManiItemTile` (a catalog grid cell)
/// and `ManiListRow` (no built-in trailing remove button).
public struct ManiCartLineRow: View {
    @Environment(\.maniTheme) private var theme
    private let title: String
    private let subtitle: String
    private let totalText: String
    private let quantityUnitText: String
    private let onTap: () -> Void
    private let onRemove: () -> Void

    public init(
        title: String,
        subtitle: String,
        totalText: String,
        quantityUnitText: String,
        onTap: @escaping () -> Void,
        onRemove: @escaping () -> Void
    ) {
        self.title = title
        self.subtitle = subtitle
        self.totalText = totalText
        self.quantityUnitText = quantityUnitText
        self.onTap = onTap
        self.onRemove = onRemove
    }

    public var body: some View {
        Button(action: onTap) {
            HStack(spacing: ManiSpacing.md) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(theme.typography.body.weight(.medium))
                        .foregroundStyle(theme.base.text)
                    Text(subtitle)
                        .font(theme.typography.secondary)
                        .foregroundStyle(theme.base.textSecondary)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 2) {
                    Text(totalText)
                        .font(theme.typography.body.weight(.semibold).monospacedDigit())
                        .foregroundStyle(theme.base.text)
                    Text(quantityUnitText)
                        .font(theme.typography.secondary)
                        .foregroundStyle(theme.base.textSecondary)
                }

                Button(action: onRemove) {
                    IconView(.close, size: 14, color: theme.base.textSecondary)
                        .padding(ManiSpacing.xs)
                }
                .buttonStyle(.plain)
            }
            .padding(.vertical, ManiSpacing.sm)
            .padding(.horizontal, ManiSpacing.md)
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
