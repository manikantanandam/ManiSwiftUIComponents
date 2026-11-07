import SwiftUI

/// e.g. the checkout payment-mode control (Cash/UPI/Card/Credit/Split).
public struct ManiSegmentedControl<T: Hashable>: View {
    @Environment(\.maniTheme) private var theme

    private let options: [(value: T, title: String)]
    @Binding private var selection: T

    public init(selection: Binding<T>, options: [(value: T, title: String)]) {
        self._selection = selection
        self.options = options
    }

    public var body: some View {
        HStack(spacing: 2) {
            ForEach(options, id: \.value) { option in
                let isSelected = option.value == selection
                Button {
                    selection = option.value
                } label: {
                    Text(option.title)
                        .font(theme.typography.secondary.weight(.semibold))
                        .foregroundStyle(isSelected ? selectedForeground : theme.base.textSecondary)
                        .frame(maxWidth: .infinity, minHeight: 36)
                }
                .background(isSelected ? selectedBackground : .clear)
                .clipShape(RoundedRectangle(cornerRadius: theme.radii.chip, style: .continuous))
            }
        }
        .padding(2)
        .background(theme.base.background)
        .clipShape(RoundedRectangle(cornerRadius: theme.radii.chip, style: .continuous))
    }

    private var selectedBackground: Color {
        theme.style == .bold ? theme.accent.accent : theme.base.surface
    }

    private var selectedForeground: Color {
        theme.style == .bold ? theme.accent.on : theme.base.text
    }
}
