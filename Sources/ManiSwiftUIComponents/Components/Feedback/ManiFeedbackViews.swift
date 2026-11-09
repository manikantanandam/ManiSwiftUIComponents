import SwiftUI

/// "Step 2 of 4" with a segmented progress bar, for onboarding.
public struct ManiStepIndicator: View {
    @Environment(\.maniTheme) private var theme
    private let current: Int
    private let total: Int

    public init(current: Int, total: Int) {
        self.current = current
        self.total = total
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: ManiSpacing.xs) {
            Text("Step \(current) of \(total)")
                .font(theme.typography.secondary)
                .foregroundStyle(theme.base.textSecondary)
            HStack(spacing: ManiSpacing.xs) {
                ForEach(1...max(total, 1), id: \.self) { step in
                    Capsule()
                        .fill(step <= current ? theme.accent.accent : theme.base.border)
                        .frame(height: 4)
                }
            }
        }
    }
}

/// Centred icon, title, message and optional action — empty lists, "check your inbox", locked features.
public struct ManiEmptyState: View {
    @Environment(\.maniTheme) private var theme
    private let icon: ManiIconName
    private let title: String
    private let message: String?
    private let actionTitle: String?
    private let action: (() -> Void)?

    public init(icon: ManiIconName, title: String, message: String? = nil,
                actionTitle: String? = nil, action: (() -> Void)? = nil) {
        self.icon = icon
        self.title = title
        self.message = message
        self.actionTitle = actionTitle
        self.action = action
    }

    public var body: some View {
        VStack(spacing: ManiSpacing.md) {
            ZStack {
                Circle().fill(theme.accent.soft).frame(width: 72, height: 72)
                IconView(icon, size: 30, color: theme.accent.accent)
            }
            Text(title)
                .font(theme.typography.screenTitle)
                .foregroundStyle(theme.base.text)
                .multilineTextAlignment(.center)
            if let message {
                Text(message)
                    .font(theme.typography.body)
                    .foregroundStyle(theme.base.textSecondary)
                    .multilineTextAlignment(.center)
            }
            if let actionTitle, let action {
                ManiButton(actionTitle, action: action)
                    .padding(.top, ManiSpacing.sm)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, ManiSpacing.xl)
    }
}

public enum ManiAuthProvider: Sendable {
    case google, apple, email, phone
}

/// "Continue with Google" style button. Brand logos are passed in by the app (brand rules
/// forbid redrawing them); without one, a generic icon is shown.
public struct ManiProviderButton: View {
    @Environment(\.maniTheme) private var theme
    private let provider: ManiAuthProvider
    private let title: String
    private let logo: Image?
    private let action: () -> Void

    public init(provider: ManiAuthProvider, title: String, logo: Image? = nil, action: @escaping () -> Void) {
        self.provider = provider
        self.title = title
        self.logo = logo
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: ManiSpacing.sm) {
                if let logo {
                    logo.resizable().scaledToFit().frame(width: 18, height: 18)
                } else {
                    IconView(fallbackIcon, size: 18, color: theme.base.text)
                }
                Text(title)
                    .font(theme.typography.body.weight(.semibold))
                    .foregroundStyle(theme.base.text)
            }
            .frame(maxWidth: .infinity, minHeight: 48)
        }
        .background(theme.base.surface)
        .clipShape(RoundedRectangle(cornerRadius: theme.radii.button, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: theme.radii.button, style: .continuous)
                .strokeBorder(theme.base.border, lineWidth: 1)
        )
    }

    private var fallbackIcon: ManiIconName {
        switch provider {
        case .google: .globe
        case .apple: .key
        case .email: .mail
        case .phone: .phone
        }
    }
}

/// Fixed-length code display: OTP boxes, or PIN dots when `secure`. Input comes from a `ManiKeypad`.
public struct ManiCodeField: View {
    @Environment(\.maniTheme) private var theme
    private let length: Int
    private let code: String
    private let secure: Bool

    public init(length: Int, code: String, secure: Bool = false) {
        self.length = length
        self.code = code
        self.secure = secure
    }

    public var body: some View {
        HStack(spacing: ManiSpacing.md) {
            ForEach(0..<length, id: \.self) { index in
                let characters = Array(code)
                let filled = index < characters.count
                if secure {
                    Circle()
                        .fill(filled ? theme.accent.accent : Color.clear)
                        .overlay(Circle().strokeBorder(filled ? theme.accent.accent : theme.base.border, lineWidth: 2))
                        .frame(width: 18, height: 18)
                } else {
                    Text(filled ? String(characters[index]) : "")
                        .font(theme.typography.kpiValue.monospacedDigit())
                        .foregroundStyle(theme.base.text)
                        .frame(width: 52, height: 60)
                        .background(theme.base.surface)
                        .clipShape(RoundedRectangle(cornerRadius: theme.radii.input, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: theme.radii.input, style: .continuous)
                                .strokeBorder(index == characters.count ? theme.accent.accent : theme.base.border,
                                              lineWidth: index == characters.count ? 2 : 1)
                        )
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

/// "82 of 100 free bills" style usage bar that turns amber near the limit and red at it.
public struct ManiProgressMeter: View {
    @Environment(\.maniTheme) private var theme
    private let label: String
    private let value: Double
    private let total: Double
    private let warnAt: Double

    public init(label: String, value: Double, total: Double, warnAt: Double = 0.8) {
        self.label = label
        self.value = value
        self.total = total
        self.warnAt = warnAt
    }

    private var fraction: Double { total > 0 ? min(value / total, 1) : 0 }

    private var tint: Color {
        if fraction >= 1 { return theme.base.error }
        if fraction >= warnAt { return theme.base.warning }
        return theme.accent.accent
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: ManiSpacing.xs) {
            HStack {
                Text(label)
                    .font(theme.typography.secondary)
                    .foregroundStyle(theme.base.text)
                Spacer()
                Text("\(Int(value)) / \(Int(total))")
                    .font(theme.typography.secondary.monospacedDigit())
                    .foregroundStyle(theme.base.textSecondary)
            }
            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    Capsule().fill(theme.base.border)
                    Capsule().fill(tint).frame(width: proxy.size.width * fraction)
                }
            }
            .frame(height: 8)
        }
    }
}

/// A floating bar offering to undo a just-made change while a countdown runs.
public struct ManiUndoBanner: View {
    @Environment(\.maniTheme) private var theme
    private let message: String
    private let actionTitle: String
    private let action: () -> Void

    public init(message: String, actionTitle: String, action: @escaping () -> Void) {
        self.message = message
        self.actionTitle = actionTitle
        self.action = action
    }

    public var body: some View {
        HStack(spacing: ManiSpacing.md) {
            IconView(.undo, size: 16, color: theme.accent.on)
            Text(message)
                .font(theme.typography.secondary)
                .foregroundStyle(theme.accent.on)
            Spacer()
            Button(actionTitle, action: action)
                .font(theme.typography.secondary.weight(.bold))
                .foregroundStyle(theme.accent.on)
        }
        .padding(ManiSpacing.md)
        .background(theme.base.text)
        .clipShape(RoundedRectangle(cornerRadius: theme.radii.card, style: .continuous))
    }
}
