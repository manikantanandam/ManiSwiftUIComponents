import SwiftUI

private struct ManiThemeContextKey: EnvironmentKey {
    static let defaultValue = ManiThemeContext.fallback
}

public extension EnvironmentValues {
    /// The resolved theme every `Mani*` component reads. Set this by
    /// applying `.maniTheme(_:style:)` up the view tree, not directly.
    var maniTheme: ManiThemeContext {
        get { self[ManiThemeContextKey.self] }
        set { self[ManiThemeContextKey.self] = newValue }
    }
}

private struct ManiThemeModifier: ViewModifier {
    let theme: any ManiTheme
    let style: ManiStyle
    @Environment(\.colorScheme) private var colorScheme

    func body(content: Content) -> some View {
        content.environment(\.maniTheme, ManiThemeContext.resolve(theme: theme, style: style, scheme: colorScheme))
    }
}

public extension View {
    /// Injects a resolved theme for this view and its descendants.
    /// Re-resolves automatically on light/dark mode changes. Use this
    /// overload for a concrete/literal theme, e.g. `.maniTheme(.apoorvaInk)`.
    func maniTheme<T: ManiTheme>(_ theme: T, style: ManiStyle = .clean) -> some View {
        modifier(ManiThemeModifier(theme: theme, style: style))
    }

    /// Same as `maniTheme(_:style:)`, but for a theme whose concrete type
    /// isn't known at compile time — e.g. read from your own `@Observable`
    /// theme store, where the resolved theme can change at runtime. Type-erased
    /// to `AnyView` because an opaque `some View` return can't vary its
    /// underlying type across calls with different existential inputs.
    func maniThemeErased(_ theme: any ManiTheme, style: ManiStyle = .clean) -> AnyView {
        AnyView(modifier(ManiThemeModifier(theme: theme, style: style)))
    }
}
