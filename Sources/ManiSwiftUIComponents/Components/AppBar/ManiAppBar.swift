import SwiftUI

public struct ManiAppBar<Leading: View, Trailing: View>: View {
    @Environment(\.maniTheme) private var theme
    private let title: String
    private let leading: Leading?
    private let trailing: Trailing?

    public init(
        title: String,
        @ViewBuilder leading: () -> Leading = { EmptyView() },
        @ViewBuilder trailing: () -> Trailing = { EmptyView() }
    ) {
        self.title = title
        self.leading = leading()
        self.trailing = trailing()
    }

    public var body: some View {
        HStack(spacing: ManiSpacing.sm) {
            leading
            Text(title)
                .font(theme.typography.screenTitle)
                .foregroundStyle(theme.base.text)
            Spacer()
            trailing
        }
        .padding(.horizontal, ManiSpacing.lg)
        .padding(.vertical, ManiSpacing.sm)
        .background(theme.base.background)
    }
}
