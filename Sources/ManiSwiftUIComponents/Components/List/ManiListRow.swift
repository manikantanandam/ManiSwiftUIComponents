import SwiftUI

/// e.g. a bills-list row: avatar, customer name, bill #/time, amount, status.
public struct ManiListRow: View {
    @Environment(\.maniTheme) private var theme

    private let avatar: ManiAvatar?
    private let title: String
    private let subtitle: String?
    private let value: String?
    private let status: (text: String, kind: ManiStatusKind)?
    private let action: (() -> Void)?

    public init(
        avatar: ManiAvatar? = nil,
        title: String,
        subtitle: String? = nil,
        value: String? = nil,
        status: (text: String, kind: ManiStatusKind)? = nil,
        action: (() -> Void)? = nil
    ) {
        self.avatar = avatar
        self.title = title
        self.subtitle = subtitle
        self.value = value
        self.status = status
        self.action = action
    }

    public var body: some View {
        Button {
            action?()
        } label: {
            HStack(spacing: ManiSpacing.md) {
                avatar

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(theme.typography.body.weight(.medium))
                        .foregroundStyle(theme.base.text)
                    if let subtitle {
                        Text(subtitle)
                            .font(theme.typography.secondary)
                            .foregroundStyle(theme.base.textSecondary)
                    }
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    if let value {
                        Text(value)
                            .font(theme.typography.body.weight(.semibold).monospacedDigit())
                            .foregroundStyle(theme.base.text)
                    }
                    if let status {
                        ManiStatusBadge(status.text, kind: status.kind)
                    }
                }
            }
            .padding(.vertical, ManiSpacing.sm)
        }
        .disabled(action == nil)
        .buttonStyle(.plain)
    }
}
