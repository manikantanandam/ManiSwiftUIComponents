import SwiftUI

public enum ManiButtonKind: Sendable {
    case primary
    case secondary
    case outline
}

public struct ManiButton: View {
    @Environment(\.maniTheme) private var theme

    private let title: String
    private let icon: ManiIconName?
    private let kind: ManiButtonKind
    private let isLoading: Bool
    private let isEnabled: Bool
    private let action: () -> Void

    public init(
        _ title: String,
        icon: ManiIconName? = nil,
        kind: ManiButtonKind = .primary,
        isLoading: Bool = false,
        isEnabled: Bool = true,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.kind = kind
        self.isLoading = isLoading
        self.isEnabled = isEnabled
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: ManiSpacing.sm) {
                if isLoading {
                    ProgressView().tint(foreground)
                } else {
                    if let icon {
                        IconView(icon, size: 18, color: foreground)
                    }
                    Text(title)
                        .font(theme.typography.body.weight(.semibold))
                        .foregroundStyle(foreground)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 48)
        }
        .background(background)
        .foregroundStyle(foreground)
        .clipShape(RoundedRectangle(cornerRadius: theme.radii.button, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: theme.radii.button, style: .continuous)
                .strokeBorder(kind == .outline ? theme.base.border : .clear, lineWidth: 1)
        )
        .opacity(isEnabled ? 1 : 0.5)
        .disabled(!isEnabled || isLoading)
    }

    private var background: Color {
        switch kind {
        case .primary: theme.accent.accent
        case .secondary: theme.base.surface
        case .outline: .clear
        }
    }

    private var foreground: Color {
        switch kind {
        case .primary: theme.accent.on
        case .secondary, .outline: theme.base.text
        }
    }
}
