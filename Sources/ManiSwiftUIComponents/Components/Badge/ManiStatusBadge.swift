import SwiftUI

/// Status is always text + color, never color alone (accessibility rule).
public enum ManiStatusKind: Sendable {
    case success
    case warning
    case error
    case neutral
}

public struct ManiStatusBadge: View {
    @Environment(\.maniTheme) private var theme
    private let text: String
    private let kind: ManiStatusKind

    public init(_ text: String, kind: ManiStatusKind) {
        self.text = text
        self.kind = kind
    }

    public var body: some View {
        Text(text)
            .font(theme.typography.secondary.weight(.semibold))
            .foregroundStyle(foreground)
            .padding(.horizontal, ManiSpacing.sm)
            .padding(.vertical, 4)
            .background(background)
            .clipShape(Capsule())
    }

    private var foreground: Color {
        switch kind {
        case .success: theme.base.success
        case .warning: theme.base.warning
        case .error: theme.base.error
        case .neutral: theme.base.textSecondary
        }
    }

    private var background: Color {
        foreground.opacity(theme.style == .bold ? 0.22 : 0.13)
    }
}
