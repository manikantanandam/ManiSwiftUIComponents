import SwiftUI

/// A curated allow-list of SF Symbol names, rather than free-form strings,
/// so this package can't silently reference a symbol with no sensible
/// Material Symbol mapping under Skip on Android. Validate new additions
/// against an actual Android build before relying on them.
public enum ManiIconName: String, Sendable, CaseIterable {
    case search
    case cart = "cart.fill"
    case customer = "person.fill"
    case customers = "person.2.fill"
    case chevronRight = "chevron.right"
    case chevronDown = "chevron.down"
    case check = "checkmark"
    case checkCircle = "checkmark.circle.fill"
    case close = "xmark"
    case plus
    case minus
    case calendar
    case clock
    case receipt = "doc.text"
    case printer
    case share = "square.and.arrow.up"
    case filter = "line.3.horizontal.decrease"
    case lock = "lock.fill"
    case info = "info.circle.fill"
    case warning = "exclamationmark.triangle.fill"
    case home
    case bills = "list.bullet.rectangle"
    case more = "ellipsis"
    case qrCode = "qrcode"
    case card = "creditcard.fill"
    case cash = "banknote.fill"
    case splitPayment = "arrow.triangle.branch"
    case avatar = "person.crop.circle.fill"
    case photo
    case image = "photo.on.rectangle"
}

public struct IconView: View {
    private let name: ManiIconName
    private let size: CGFloat
    private let color: Color?

    public init(_ name: ManiIconName, size: CGFloat = 20, color: Color? = nil) {
        self.name = name
        self.size = size
        self.color = color
    }

    public var body: some View {
        Image(systemName: name.rawValue)
            .font(.system(size: size, weight: .regular))
            .foregroundStyle(color ?? .primary)
            .frame(width: size, height: size)
    }
}
