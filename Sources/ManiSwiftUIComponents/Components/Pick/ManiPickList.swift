import SwiftUI

public struct ManiPickOption<Value: Hashable>: Identifiable {
    public var id: Value { value }
    public let value: Value
    public let title: String
    public let subtitle: String?
    public let swatch: Color?
    public let icon: ManiIconName?
    /// Renders the title in this font, e.g. to preview a font family.
    public let titleFont: Font?

    public init(value: Value, title: String, subtitle: String? = nil, swatch: Color? = nil,
                icon: ManiIconName? = nil, titleFont: Font? = nil) {
        self.value = value
        self.title = title
        self.subtitle = subtitle
        self.swatch = swatch
        self.icon = icon
        self.titleFont = titleFont
    }
}

/// A single-choice radio list (shop type, language, printer, environment, font, store…).
public struct ManiPickList<Value: Hashable>: View {
    @Environment(\.maniTheme) private var theme
    private let options: [ManiPickOption<Value>]
    @Binding private var selection: Value

    public init(options: [ManiPickOption<Value>], selection: Binding<Value>) {
        self.options = options
        self._selection = selection
    }

    public var body: some View {
        VStack(spacing: ManiSpacing.sm) {
            ForEach(options) { option in
                let isSelected = option.value == selection
                Button {
                    selection = option.value
                } label: {
                    HStack(spacing: ManiSpacing.md) {
                        if let swatch = option.swatch {
                            Circle().fill(swatch).frame(width: 14, height: 14)
                        } else if let icon = option.icon {
                            IconView(icon, size: 18, color: theme.base.textSecondary)
                        }
                        VStack(alignment: .leading, spacing: 2) {
                            Text(option.title)
                                .font(option.titleFont ?? theme.typography.body.weight(.medium))
                                .foregroundStyle(theme.base.text)
                            if let subtitle = option.subtitle {
                                Text(subtitle)
                                    .font(theme.typography.secondary)
                                    .foregroundStyle(theme.base.textSecondary)
                            }
                        }
                        Spacer()
                        ZStack {
                            Circle()
                                .strokeBorder(isSelected ? theme.accent.accent : theme.base.border, lineWidth: 2)
                                .frame(width: 22, height: 22)
                            if isSelected {
                                Circle().fill(theme.accent.accent).frame(width: 12, height: 12)
                            }
                        }
                    }
                    .padding(ManiSpacing.md)
                    .frame(minHeight: ManiTouchTarget.minimum)
                    .background(isSelected ? theme.accent.soft : theme.base.surface)
                    .clipShape(RoundedRectangle(cornerRadius: theme.radii.card, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: theme.radii.card, style: .continuous)
                            .strokeBorder(isSelected ? theme.accent.accent : theme.base.border, lineWidth: 1)
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }
}

/// A row of colour circles; the selected one gets a ring and a checkmark.
public struct ManiSwatchRow<Value: Hashable>: View {
    @Environment(\.maniTheme) private var theme
    private let options: [(value: Value, title: String, color: Color)]
    @Binding private var selection: Value

    public init(options: [(value: Value, title: String, color: Color)], selection: Binding<Value>) {
        self.options = options
        self._selection = selection
    }

    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: ManiSpacing.md) {
                ForEach(options, id: \.value) { option in
                    let isSelected = option.value == selection
                    Button {
                        selection = option.value
                    } label: {
                        VStack(spacing: ManiSpacing.xs) {
                            ZStack {
                                Circle().fill(option.color).frame(width: 40, height: 40)
                                if isSelected {
                                    Circle().strokeBorder(theme.base.text, lineWidth: 2).frame(width: 48, height: 48)
                                    IconView(.check, size: 16, color: .white)
                                }
                            }
                            .frame(width: 48, height: 48)
                            Text(option.title)
                                .font(.system(size: 11))
                                .foregroundStyle(theme.base.textSecondary)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.vertical, ManiSpacing.xs)
        }
    }
}
