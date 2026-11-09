import SwiftUI

/// The big centred amount used on collect, discount, weight, receipt and similar screens.
public struct ManiHeroAmount: View {
    @Environment(\.maniTheme) private var theme
    private let amount: String
    private let caption: String?
    private let icon: ManiIconName?
    private let tint: Color?

    public init(_ amount: String, caption: String? = nil, icon: ManiIconName? = nil, tint: Color? = nil) {
        self.amount = amount
        self.caption = caption
        self.icon = icon
        self.tint = tint
    }

    public var body: some View {
        VStack(spacing: ManiSpacing.xs) {
            if let icon {
                IconView(icon, size: 40, color: tint ?? theme.base.success)
                    .padding(.bottom, ManiSpacing.xs)
            }
            Text(amount)
                .font(theme.typography.heroValue.monospacedDigit())
                .foregroundStyle(theme.base.text)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            if let caption {
                Text(caption)
                    .font(theme.typography.secondary)
                    .foregroundStyle(theme.base.textSecondary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, ManiSpacing.lg)
    }
}
