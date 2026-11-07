import SwiftUI

/// A POS product grid tile with a quantity badge and +/- controls.
public struct ManiItemTile: View {
    @Environment(\.maniTheme) private var theme
    private let imageURL: URL?
    private let title: String
    private let priceText: String
    private let quantity: Int
    private let onIncrement: () -> Void
    private let onDecrement: () -> Void

    public init(
        imageURL: URL? = nil,
        title: String,
        priceText: String,
        quantity: Int,
        onIncrement: @escaping () -> Void,
        onDecrement: @escaping () -> Void
    ) {
        self.imageURL = imageURL
        self.title = title
        self.priceText = priceText
        self.quantity = quantity
        self.onIncrement = onIncrement
        self.onDecrement = onDecrement
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: ManiSpacing.xs) {
            ZStack(alignment: .topTrailing) {
                thumbnail
                if quantity > 0 {
                    Text("\(quantity)")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(theme.accent.on)
                        .frame(width: 20, height: 20)
                        .background(theme.accent.accent)
                        .clipShape(Circle())
                        .offset(x: 6, y: -6)
                }
            }

            Text(title)
                .font(theme.typography.body)
                .foregroundStyle(theme.base.text)
                .lineLimit(2)

            HStack {
                Text(priceText)
                    .font(theme.typography.body.weight(.semibold).monospacedDigit())
                    .foregroundStyle(theme.base.text)
                Spacer()
                stepper
            }
        }
        .padding(ManiSpacing.sm)
        .background(theme.base.surface)
        .clipShape(RoundedRectangle(cornerRadius: theme.radii.card, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: theme.radii.card, style: .continuous)
                .strokeBorder(theme.base.border, lineWidth: 1)
        )
    }

    @ViewBuilder private var thumbnail: some View {
        RoundedRectangle(cornerRadius: theme.radii.chip, style: .continuous)
            .fill(theme.base.background)
            .frame(height: 72)
            .overlay {
                if let imageURL {
                    AsyncImage(url: imageURL) { $0.resizable().scaledToFill() } placeholder: {
                        IconView(.image, size: 24, color: theme.base.textSecondary)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: theme.radii.chip, style: .continuous))
                } else {
                    IconView(.image, size: 24, color: theme.base.textSecondary)
                }
            }
    }

    @ViewBuilder private var stepper: some View {
        if quantity > 0 {
            HStack(spacing: ManiSpacing.sm) {
                Button(action: onDecrement) { IconView(.minus, size: 14, color: theme.accent.accent) }
                Text("\(quantity)").font(theme.typography.secondary.weight(.semibold)).monospacedDigit()
                Button(action: onIncrement) { IconView(.plus, size: 14, color: theme.accent.accent) }
            }
            .buttonStyle(.plain)
        } else {
            Button(action: onIncrement) {
                IconView(.plus, size: 16, color: theme.accent.on)
                    .padding(6)
                    .background(theme.accent.accent)
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
        }
    }
}
