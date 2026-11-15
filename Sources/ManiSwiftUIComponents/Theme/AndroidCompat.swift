#if os(Android)
import SwiftUI

// SkipSwiftUI marks `Font.monospacedDigit()` unavailable and declares `strokeBorder` ambiguously.
// Declaring the same signatures in this module shadows the imported ones so call sites stay unchanged.

extension Font {
    func monospacedDigit() -> Font { self }
}

extension InsettableShape {
    func strokeBorder<S: ShapeStyle>(_ content: S, lineWidth: CGFloat = 1, antialiased: Bool = true) -> some View {
        stroke(content, lineWidth: lineWidth)
    }
}
#endif
