import SwiftUI

/// A horizontally scrolling row of chips with single selection, e.g. the
/// bills-list filter row (Today/Yesterday/This week/Unpaid).
public struct ManiChipGroup<T: Hashable>: View {
    private let items: [T]
    private let label: (T) -> String
    @Binding private var selection: T?

    public init(items: [T], label: @escaping (T) -> String, selection: Binding<T?>) {
        self.items = items
        self.label = label
        self._selection = selection
    }

    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: ManiSpacing.sm) {
                ForEach(items, id: \.self) { item in
                    ManiChip(label(item), isSelected: selection == item) {
                        selection = (selection == item) ? nil : item
                    }
                }
            }
        }
    }
}
