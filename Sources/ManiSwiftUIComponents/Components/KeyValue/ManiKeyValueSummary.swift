import SwiftUI

public struct ManiKeyValue: Identifiable, Sendable {
    public let id = UUID()
    public let label: String
    public let value: String

    public init(_ label: String, _ value: String) {
        self.label = label
        self.value = value
    }
}

/// A card of label/value rows, e.g. a bill total breakdown or a statement summary.
/// The last row can be emphasised as the total.
public struct ManiKeyValueSummary: View {
    private let rows: [ManiKeyValue]
    private let emphasizeLast: Bool

    public init(rows: [ManiKeyValue], emphasizeLast: Bool = true) {
        self.rows = rows
        self.emphasizeLast = emphasizeLast
    }

    public var body: some View {
        ManiCard {
            VStack(spacing: ManiSpacing.sm) {
                ForEach(Array(rows.enumerated()), id: \.element.id) { index, row in
                    let isLast = index == rows.count - 1
                    if isLast && emphasizeLast && rows.count > 1 {
                        Divider()
                    }
                    ManiBreakdownRow(label: row.label, value: row.value,
                                     emphasis: isLast && emphasizeLast ? .total : .normal)
                }
            }
        }
    }
}
