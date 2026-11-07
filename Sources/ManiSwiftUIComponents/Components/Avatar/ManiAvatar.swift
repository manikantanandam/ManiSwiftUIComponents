import SwiftUI

public struct ManiAvatar: View {
    @Environment(\.maniTheme) private var theme
    private let initials: String?
    private let imageURL: URL?
    private let size: CGFloat

    public init(initials: String? = nil, imageURL: URL? = nil, size: CGFloat = 40) {
        self.initials = initials
        self.imageURL = imageURL
        self.size = size
    }

    public var body: some View {
        ZStack {
            Circle().fill(theme.accent.soft)
            if let imageURL {
                AsyncImage(url: imageURL) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    initialsText
                }
                .clipShape(Circle())
            } else {
                initialsText
            }
        }
        .frame(width: size, height: size)
    }

    @ViewBuilder private var initialsText: some View {
        if let initials {
            Text(initials)
                .font(.system(size: size * 0.4, weight: .semibold))
                .foregroundStyle(theme.accent.accent)
        } else {
            IconView(.avatar, size: size * 0.6, color: theme.accent.accent)
        }
    }
}
