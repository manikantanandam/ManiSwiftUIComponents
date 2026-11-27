import SwiftUI

/// Status is always text + color, never color alone (accessibility rule).
public enum ManiStatusKind: Sendable {
    case success
    case warning
    case error
    case neutral
}

/// Per-screen badge sizing; `.regular` is the original look.
public enum ManiBadgeSize: Sendable {
    case regular
    case compact
    case tiny
}

public struct ManiStatusBadge: View {
    @Environment(\.maniTheme) var theme
    private let text: String
    private let kind: ManiStatusKind
    private let size: ManiBadgeSize

    public init(_ text: String, kind: ManiStatusKind, size: ManiBadgeSize = .regular) {
        self.text = text
        self.kind = kind
        self.size = size
    }

    public var body: some View {
        Text(text)
            .font(font)
            .foregroundStyle(foreground)
            .lineLimit(1)
            .fixedSize()
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .background(background)
            .clipShape(Capsule())
    }

    private var font: Font {
        switch size {
        case .regular: theme.typography.secondary.weight(.semibold)
        case .compact: .system(size: 11, weight: .semibold)
        case .tiny: .system(size: 9, weight: .semibold)
        }
    }

    private var horizontalPadding: CGFloat {
        switch size {
        case .regular: ManiSpacing.sm
        case .compact: 6
        case .tiny: 4
        }
    }

    private var verticalPadding: CGFloat {
        switch size {
        case .regular: 4
        case .compact: 2
        case .tiny: 0.5
        }
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
