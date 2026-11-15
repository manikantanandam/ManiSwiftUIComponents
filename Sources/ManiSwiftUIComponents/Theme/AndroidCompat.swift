import SwiftUI

// SkipSwiftUI (Android) declares `strokeBorder` ambiguously and marks `monospacedDigit()` unavailable.
// `maniBorder` is the single call site for both platforms; Android strokes centred instead of inset.

extension InsettableShape {
    func maniBorder<S: ShapeStyle>(_ content: S, lineWidth: CGFloat = 1) -> some View {
        #if os(Android)
        stroke(content, lineWidth: lineWidth)
        #else
        strokeBorder(content, lineWidth: lineWidth)
        #endif
    }
}

#if os(Android)
extension Font {
    func monospacedDigit() -> Font { self }
}

extension Text {
    func monospacedDigit() -> Text { self }
}
#endif
