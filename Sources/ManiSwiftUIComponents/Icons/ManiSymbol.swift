import Foundation

/// SF Symbol names as the current platform can draw them. On Android, Skip draws only the SF Symbols in its
/// fallback table (about 65 names mapped to Material icons) and shows a warning triangle for any other name,
/// so other names are swapped for the closest mapped symbol. Apple platforms get the name unchanged.
public enum ManiSymbol {
    public static func name(_ name: String) -> String {
        #if os(Android)
        return androidFallbacks[name] ?? name
        #else
        return name
        #endif
    }

    #if os(Android)
    /// Unmapped SF Symbol -> closest symbol in Skip's fallback table (skip-ui README, "System Symbols").
    static let androidFallbacks: [String: String] = [
        "arrow.clockwise": "arrow.clockwise.circle",
        "arrow.down.app": "arrow.clockwise.circle",
        "arrow.down.circle": "chevron.down",
        "arrow.down.left.circle": "arrow.left",
        "arrow.triangle.2.circlepath": "arrow.clockwise.circle",
        "arrow.triangle.branch": "arrow.forward",
        "arrow.up": "chevron.up",
        "arrow.up.arrow.down": "chevron.down",
        "arrow.up.circle": "chevron.up",
        "arrow.up.right.circle": "arrow.forward",
        "arrow.uturn.backward": "arrow.left",
        "banknote.fill": "cart.fill",
        "barcode.viewfinder": "magnifyingglass",
        "camera": "plus",
        "chart.bar": "list.bullet",
        "checkmark.shield": "checkmark.circle",
        "chevron.left.circle.fill": "chevron.left",
        "chevron.right.circle.fill": "chevron.right",
        "clock": "calendar",
        "clock.arrow.circlepath": "arrow.clockwise.circle",
        "clock.badge.checkmark": "checkmark.circle",
        "creditcard.fill": "cart.fill",
        "delete.left": "arrow.left",
        "doc.text": "list.bullet",
        "doc.text.below.ecg": "list.bullet",
        "flag": "star.fill",
        "gift": "star.fill",
        "globe": "location",
        "hammer": "wrench",
        "home": "house",
        "iphone": "phone",
        "iphone.gen1": "phone",
        "key": "lock",
        "line.3.horizontal.decrease": "line.3.horizontal",
        "line.3.horizontal.decrease.circle": "line.3.horizontal",
        "link": "paperplane",
        "list.bullet.rectangle": "list.bullet",
        "lock.open": "lock",
        "message.fill": "envelope.fill",
        "minus": "xmark",
        "paintpalette": "gearshape",
        "pause.fill": "arrow.forward.square",  // no pause icon in the table; "Hold bill" sets the bill aside
        "pencil.and.list.clipboard": "pencil",
        "percent": "cart",
        "person.2": "person",
        "person.2.fill": "person.fill",
        "person.3": "person",
        "person.crop.rectangle": "person.crop.square",
        "photo": "face.smiling",
        "photo.on.rectangle": "face.smiling",
        "plus.square.dashed": "plus",
        "printer": "paperplane",
        "qrcode": "magnifyingglass",
        "questionmark.circle": "info.circle",
        "rectangle.portrait.and.arrow.right": "arrow.forward.square",
        "scalemass": "cart",
        "shippingbox": "cart",
        "sparkles": "star.fill",
        "square.grid.2x2": "line.3.horizontal",
        "storefront": "house",
        "sun.max": "gearshape",
        "tag": "cart",
        "text.alignleft": "line.3.horizontal",
        "textformat": "pencil",
        "touchid": "lock",
        "tray.full.fill": "list.bullet",
        "truck.box": "cart",
        "wallet.pass": "cart",
        "wifi.slash": "exclamationmark.triangle",
        "wrench.and.screwdriver": "wrench",
    ]
    #endif
}
