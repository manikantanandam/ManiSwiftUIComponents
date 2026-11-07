import SwiftUI

public struct ManiToggleRow: View {
    @Environment(\.maniTheme) private var theme
    private let title: String
    private let subtitle: String?
    @Binding private var isOn: Bool
    private let isLocked: Bool

    public init(title: String, subtitle: String? = nil, isOn: Binding<Bool>, isLocked: Bool = false) {
        self.title = title
        self.subtitle = subtitle
        self._isOn = isOn
        self.isLocked = isLocked
    }

    public var body: some View {
        HStack(spacing: ManiSpacing.sm) {
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: ManiSpacing.xs) {
                    Text(title)
                        .font(theme.typography.body)
                        .foregroundStyle(theme.base.text)
                    if isLocked {
                        IconView(.lock, size: 12, color: theme.base.textSecondary)
                    }
                }
                if let subtitle {
                    Text(subtitle)
                        .font(theme.typography.secondary)
                        .foregroundStyle(theme.base.textSecondary)
                }
            }
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(theme.accent.accent)
                .disabled(isLocked)
        }
        .padding(.vertical, ManiSpacing.sm)
    }
}
