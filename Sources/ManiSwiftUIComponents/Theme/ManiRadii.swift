import Foundation

/// Corner radii, varying by `ManiStyle`.
public struct ManiRadii: Sendable {
    public let card: CGFloat
    public let button: CGFloat
    public let chip: CGFloat
    public let sheet: CGFloat
    public let input: CGFloat

    public init(style: ManiStyle) {
        switch style {
        case .clean:
            card = 12
            button = 10
            chip = 8
            sheet = 20
            input = 10
        case .bold:
            card = 16
            button = 14
            chip = 999 // pill
            sheet = 20
            input = 10
        }
    }
}
