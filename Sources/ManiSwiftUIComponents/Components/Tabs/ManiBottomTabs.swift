import SwiftUI

public struct ManiTabItem: Sendable, Identifiable {
    public let id = UUID()
    public let icon: ManiIconName
    public let title: String

    public init(icon: ManiIconName, title: String) {
        self.icon = icon
        self.title = title
    }
}

public struct ManiTabCenterAction: Sendable {
    public let icon: ManiIconName
    public let action: @MainActor @Sendable () -> Void

    public init(icon: ManiIconName = .plus, action: @MainActor @Sendable @escaping () -> Void) {
        self.icon = icon
        self.action = action
    }
}

/// Home | Bills | [+ New bill] | Customers | More, with a raised circular
/// (Clean) or square (Bold) center action.
public struct ManiBottomTabs: View {
    @Environment(\.maniTheme) private var theme
    private let tabs: [ManiTabItem]
    @Binding private var selection: Int
    private let centerAction: ManiTabCenterAction?

    public init(tabs: [ManiTabItem], selection: Binding<Int>, centerAction: ManiTabCenterAction? = nil) {
        self.tabs = tabs
        self._selection = selection
        self.centerAction = centerAction
    }

    public var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(tabs.enumerated()), id: \.offset) { index, tab in
                if let centerAction, index == tabs.count / 2 {
                    centerButton(centerAction)
                }
                tabButton(tab, index: index)
            }
            if let centerAction, tabs.isEmpty {
                centerButton(centerAction)
            }
        }
        .padding(.horizontal, ManiSpacing.sm)
        .padding(.top, ManiSpacing.sm)
        .background(theme.base.surface)
        .overlay(Rectangle().fill(theme.base.border).frame(height: 1), alignment: .top)
    }

    private func tabButton(_ tab: ManiTabItem, index: Int) -> some View {
        let isSelected = index == selection
        return Button {
            selection = index
        } label: {
            VStack(spacing: 2) {
                IconView(tab.icon, size: 22, color: isSelected ? theme.accent.accent : theme.base.textSecondary)
                Text(tab.title)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(isSelected ? theme.accent.accent : theme.base.textSecondary)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }

    private func centerButton(_ centerAction: ManiTabCenterAction) -> some View {
        Button(action: centerAction.action) {
            IconView(centerAction.icon, size: 24, color: theme.accent.on)
                .frame(width: 52, height: 52)
                .background(theme.accent.accent)
                .clipShape(theme.style == .bold ? AnyShape(RoundedRectangle(cornerRadius: 14, style: .continuous)) : AnyShape(Circle()))
                .offset(y: -12)
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
    }
}
