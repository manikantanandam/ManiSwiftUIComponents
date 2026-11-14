import SwiftUI

/// A curated allow-list of SF Symbol names, rather than free-form strings,
/// so this package can't silently reference a symbol with no sensible
/// Material Symbol mapping under Skip on Android. Validate new additions
/// against an actual Android build before relying on them.
public enum ManiIconName: String, Sendable, CaseIterable {
    case search = "magnifyingglass"
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
    case credit = "clock.badge.checkmark"
    case splitPayment = "arrow.triangle.branch"
    case avatar = "person.crop.circle.fill"
    case photo
    case image = "photo.on.rectangle"
    case pause = "pause.fill"
    case tray = "tray.full.fill"
    case settings = "gearshape"
    case bell
    case sync = "arrow.triangle.2.circlepath"
    case chart = "chart.bar"
    case box = "shippingbox"
    case truck = "truck.box"
    case wallet = "wallet.pass"
    case star = "star.fill"
    case phone = "phone.fill"
    case message = "message.fill"
    case scan = "barcode.viewfinder"
    case trash
    case edit = "pencil"
    case undo = "arrow.uturn.backward"
    case download = "arrow.down.circle"
    case upload = "arrow.up.circle"
    case globe
    case fingerprint = "touchid"
    case mail = "envelope"
    case gift
    case tag
    case scale = "scalemass"
    case history = "clock.arrow.circlepath"
    case help = "questionmark.circle"
    case signOut = "rectangle.portrait.and.arrow.right"
    case shield = "checkmark.shield"
    case device = "iphone"
    case store = "storefront"
    case grid = "square.grid.2x2"
    case list = "list.bullet"
    case backspace = "delete.left"
    case people = "person.3"
    case wifiOff = "wifi.slash"
    case drag = "line.3.horizontal"
    case camera
    case warranty = "wrench.and.screwdriver"
    case order = "doc.text.below.ecg"
    case cashIn = "arrow.down.left.circle"
    case cashOut = "arrow.up.right.circle"
    case percent
    case sparkles
    case flag
    case font = "textformat"
    case palette = "paintpalette"
    case sun = "sun.max"
    case key
    case link
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
