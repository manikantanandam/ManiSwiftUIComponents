import SwiftUI

/// A rows × columns grid of on/off cells, e.g. permissions by role, plan features, or attendance.
/// Locked cells can't be toggled (shown with a lock).
public struct ManiPermissionMatrix<Row: Hashable, Column: Hashable>: View {
    @Environment(\.maniTheme) private var theme
    private let columns: [(value: Column, title: String)]
    private let rows: [(value: Row, title: String)]
    private let value: (Row, Column) -> Bool
    private let isLocked: (Row, Column) -> Bool
    private let onToggle: ((Row, Column) -> Void)?

    public init(columns: [(value: Column, title: String)],
                rows: [(value: Row, title: String)],
                value: @escaping (Row, Column) -> Bool,
                isLocked: @escaping (Row, Column) -> Bool = { _, _ in false },
                onToggle: ((Row, Column) -> Void)? = nil) {
        self.columns = columns
        self.rows = rows
        self.value = value
        self.isLocked = isLocked
        self.onToggle = onToggle
    }

    public var body: some View {
        ManiCard(padding: ManiSpacing.sm) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ForEach(columns, id: \.value) { column in
                        Text(column.title)
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(theme.base.textSecondary)
                            .frame(width: 56)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                    }
                }
                .padding(.vertical, ManiSpacing.sm)

                ForEach(rows, id: \.value) { row in
                    Divider()
                    HStack(spacing: 0) {
                        Text(row.title)
                            .font(theme.typography.secondary)
                            .foregroundStyle(theme.base.text)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(columns, id: \.value) { column in
                            cell(row: row.value, column: column.value)
                                .frame(width: 56)
                        }
                    }
                    .padding(.vertical, ManiSpacing.sm)
                }
            }
        }
    }

    @ViewBuilder private func cell(row: Row, column: Column) -> some View {
        let isOn = value(row, column)
        let locked = isLocked(row, column)
        Button {
            onToggle?(row, column)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(isOn ? theme.accent.accent : theme.base.background)
                    .frame(width: 24, height: 24)
                if locked {
                    IconView(.lock, size: 11, color: isOn ? theme.accent.on : theme.base.textSecondary)
                } else if isOn {
                    IconView(.check, size: 12, color: theme.accent.on)
                }
            }
        }
        .buttonStyle(.plain)
        .disabled(locked || onToggle == nil)
    }
}
