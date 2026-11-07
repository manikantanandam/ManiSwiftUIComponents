import SwiftUI

public enum ManiNoteKind: Sendable {
    case info
    case warning
    case error
}

public struct ManiNote: View {
    @Environment(\.maniTheme) private var theme
    private let text: String
    private let kind: ManiNoteKind

    public init(_ text: String, kind: ManiNoteKind = .info) {
        self.text = text
        self.kind = kind
    }

    public var body: some View {
        HStack(alignment: .top, spacing: ManiSpacing.sm) {
            IconView(icon, size: 16, color: tint)
            Text(text)
                .font(theme.typography.secondary)
                .foregroundStyle(theme.base.text)
        }
        .padding(ManiSpacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(tint.opacity(0.13))
        .clipShape(RoundedRectangle(cornerRadius: theme.radii.card, style: .continuous))
    }

    private var icon: ManiIconName {
        kind == .info ? .info : .warning
    }

    private var tint: Color {
        switch kind {
        case .info: theme.accent.accent
        case .warning: theme.base.warning
        case .error: theme.base.error
        }
    }
}
