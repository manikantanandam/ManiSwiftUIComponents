import SwiftUI

public enum ManiBreakdownEmphasis: Sendable {
    case normal
    case total
}

/// e.g. checkout's subtotal/discount/round-off/total rows, or a bill
/// detail's subtotal/paid/balance-due rows.
public struct ManiBreakdownRow: View {
    @Environment(\.maniTheme) private var theme
    private let label: String
    private let value: String
    private let emphasis: ManiBreakdownEmphasis

    public init(label: String, value: String, emphasis: ManiBreakdownEmphasis = .normal) {
        self.label = label
        self.value = value
        self.emphasis = emphasis
    }

    public var body: some View {
        HStack {
            Text(label)
                .font(labelFont)
                .foregroundStyle(emphasis == .total ? theme.base.text : theme.base.textSecondary)
            Spacer()
            Text(value)
                .font(valueFont)
                .foregroundStyle(theme.base.text)
        }
    }

    private var labelFont: Font {
        emphasis == .total ? theme.typography.body.weight(.semibold) : theme.typography.body
    }

    private var valueFont: Font {
        let base = emphasis == .total ? theme.typography.kpiValue : theme.typography.body.weight(.semibold)
        return base.monospacedDigit()
    }
}
