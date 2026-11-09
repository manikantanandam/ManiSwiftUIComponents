import SwiftUI

public enum ManiKeypadKey: Hashable, Sendable {
    case digit(Int)
    case decimal
    case backspace
}

/// A 3×4 numeric keypad for amount, weight, quantity, OTP and PIN entry.
public struct ManiKeypad: View {
    @Environment(\.maniTheme) private var theme
    private let showsDecimal: Bool
    private let onKey: (ManiKeypadKey) -> Void

    public init(showsDecimal: Bool = true, onKey: @escaping (ManiKeypadKey) -> Void) {
        self.showsDecimal = showsDecimal
        self.onKey = onKey
    }

    private var rows: [[ManiKeypadKey?]] {
        [
            [.digit(1), .digit(2), .digit(3)],
            [.digit(4), .digit(5), .digit(6)],
            [.digit(7), .digit(8), .digit(9)],
            [showsDecimal ? .decimal : nil, .digit(0), .backspace]
        ]
    }

    public var body: some View {
        VStack(spacing: ManiSpacing.sm) {
            ForEach(0..<rows.count, id: \.self) { rowIndex in
                HStack(spacing: ManiSpacing.sm) {
                    ForEach(0..<3, id: \.self) { column in
                        keyView(rows[rowIndex][column])
                    }
                }
            }
        }
    }

    @ViewBuilder private func keyView(_ key: ManiKeypadKey?) -> some View {
        if let key {
            Button { onKey(key) } label: {
                label(for: key)
                    .frame(maxWidth: .infinity, minHeight: 52)
                    .background(theme.base.surface)
                    .clipShape(RoundedRectangle(cornerRadius: theme.radii.button, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: theme.radii.button, style: .continuous)
                            .strokeBorder(theme.base.border, lineWidth: 1)
                    )
            }
            .buttonStyle(.plain)
        } else {
            Color.clear.frame(maxWidth: .infinity, minHeight: 52)
        }
    }

    @ViewBuilder private func label(for key: ManiKeypadKey) -> some View {
        switch key {
        case .digit(let value):
            Text("\(value)")
                .font(theme.typography.kpiValue.monospacedDigit())
                .foregroundStyle(theme.base.text)
        case .decimal:
            Text(".")
                .font(theme.typography.kpiValue)
                .foregroundStyle(theme.base.text)
        case .backspace:
            IconView(.backspace, size: 20, color: theme.base.text)
        }
    }
}

public extension ManiKeypadKey {
    /// Applies the key to a numeric text value, enforcing one decimal point and `maxDecimals`.
    func apply(to text: String, maxDecimals: Int = 2, maxLength: Int = 9) -> String {
        switch self {
        case .digit(let value):
            if let dot = text.firstIndex(of: "."), text.distance(from: dot, to: text.endIndex) > maxDecimals { return text }
            guard text.count < maxLength else { return text }
            return text == "0" ? "\(value)" : text + "\(value)"
        case .decimal:
            guard maxDecimals > 0, !text.contains(".") else { return text }
            return (text.isEmpty ? "0" : text) + "."
        case .backspace:
            return String(text.dropLast())
        }
    }
}
