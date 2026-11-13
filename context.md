# context.md

Guidance for working in this repository — keep this current as the package evolves.

## Quick Index

- **Purpose** — independent, themeable SwiftUI component library (iOS 17+/macOS 14+); first consumer is apoorva-skip via a local `ApoorvaUI` library.
- **Design-token reference** — base color tokens, 5 accent presets, spacing, radii, typography scales (source of truth: apoorva-skip's `docs/04-ui-design.md`, mirrored here).
- **Theme architecture** — `ManiTheme` protocol, `ManiThemeContext`, `.maniTheme(...)` injection; this package does NOT implement org/user theme-resolution policy.
- **Component inventory** — table of ~17 shipped (`Mani*`) components + status; QA via `Gallery/ManiComponentGallery.swift` (no automated UI tests).
- **Usage conventions** — `Mani` prefix on every public type; new components/themes follow a fixed folder/extension pattern.
- **Skip/Android portability rules** — **no `UIKit`/`UIColor`, no `.onTapGesture`**; icons only via `ManiIconName`/`IconView`.
- **Theming-extension guide for consumers** — step-by-step for an app (e.g. `ApoorvaUI`) to define and apply its own resolved theme.
- **Decisions log** — `decisions/`: dated exploration/decision records; check before re-exploring a topic. A `Stop` hook enforces writing an entry there whenever a session explored code or exited plan mode.

## Purpose

`ManiSwiftUIComponents` is an independent, themeable SwiftUI component library. It is not tied to any one app: it provides design-token/theme infrastructure plus a set of ready-made components, and ships a few example color presets, so any consuming app can plug in its own brand colors and get consistent, theme-aware UI across its screens.

- **Platforms:** iOS 17+, macOS 14+.
- **First consumer:** [apoorva-skip](../../Skip/apoorva-skip) (Apoorva), a Skip-based (transpiles to Android/Compose) offline-first billing/POS app. Its screens are being migrated incrementally onto this package via a local `ApoorvaUI` library (see that repo's `CLAUDE.md`).
- **Portability constraint:** because its first consumer is Skip-transpiled to Kotlin/Compose for Android, this package must stay plain, portable SwiftUI. See "Skip/Android portability rules" below — this applies to every future consumer too, not just Apoorva.

## Design-token reference

Source of truth for these values: apoorva-skip's `docs/04-ui-design.md`. Mirrored here so this package is self-contained.

**Base tokens** (shared by every theme, light/dark hex):

| Token | Light | Dark |
|---|---|---|
| `background` | #F5F6F8 | #0B0D12 |
| `surface` | #FFFFFF | #151922 |
| `text` | #0F172A | #E5E7EB |
| `textSecondary` | #475569 | #A1A7B3 |
| `border` | #E2E8F0 | #262B36 |
| `success` | #15803D | #4ADE80 |
| `error` | #B91C1C | #F87171 |
| `warning` | #B45309 | #FBBF24 |

**Accent presets** (light/dark hex), each also derives `soft` = accent @13% opacity and an explicit `on` (text-on-accent) color:

| Preset | Light | Dark |
|---|---|---|
| Apoorva Ink | #3F4396 | #A5B4FC |
| Kirana Sage | #2F6F62 | #5EC4AE |
| Fancy Plum | #8A3F86 | #E0A8DC |
| Jewellery Brass | #85672C | #D9BE85 |
| Parlour Rose | #A3405C | #F0A3B8 |

> `on` values are a pragmatic default (white on light accents, dark navy on dark-mode pastel accents), not individually contrast-computed. Revisit with real visual QA before shipping a new accent to production.

**Spacing:** 4 / 8 / 12 / 16 / 24 (`ManiSpacing.xs/sm/md/lg/xl`) — identical across styles.

**Radii** (`ManiRadii(style:)`): Clean → card 12, button 10, chip 8, sheet 20, input 10. Bold → card 16, button 14, chip pill, sheet 20, input 10.

**Typography** (`ManiTypography(style:)`): Clean → screen title 22/600, section header 15/600, body 15/400, secondary 13/400, KPI 22/600, hero 36/600. Bold → screen title 22/700, section header 13/650, body 13.5/600, secondary 11.5/400, KPI/hero same sizes at heavier weight. All sizes use `Font.system` only.

Accessibility: every text/background pair must stay ≥4.5:1; status is always communicated with text + color, never color alone.

## Theme architecture

- `ManiTheme` (protocol) — a theme supplies `accentColors(for:)`; `baseColors(for:)` defaults to the shared `ManiDefaultBaseTheme` so most themes only need an accent pair.
- `ManiThemeContext` — the resolved bundle (`base`, `accent`, `style`, `radii`, `typography`) every component actually reads, via `@Environment(\.maniTheme)`.
- `View.maniTheme(_ theme: some ManiTheme, style: ManiStyle = .clean)` — inject a theme for a subtree. Resolves light/dark automatically from `colorScheme`. Use `View.maniThemeErased(_ theme: any ManiTheme, style:)` (returns `AnyView`) instead when the theme's concrete type isn't known at compile time — e.g. read from your own `@Observable` store, where the resolved theme can change at runtime.
- **This package does NOT implement org/store/user theme-resolution policy.** That logic (e.g. apoorva-skip's org-lock → user-preference → store → org → vertical-default order) belongs in the consuming app's own `@Observable` theme store, which should resolve to a `(ManiTheme, ManiStyle)` pair and apply it once at the app root with `.maniTheme(...)`. Downstream views never need to know how that pair was chosen.

## Component inventory

| Component | Status | Notes |
|---|---|---|
| ManiButton | v1 | primary/secondary/outline, loading state |
| ManiCard | v1 | |
| ManiInputField | v1 | `ManiKeyboardKind` instead of `UIKeyboardType` |
| ManiChip / ManiChipGroup | v1 | single-selection filter row |
| ManiSegmentedControl | v1 | |
| ManiStatusBadge | v1 | success/warning/error/neutral |
| ManiAvatar | v1 | initials or image |
| IconView / ManiIconName | v1 | curated SF Symbol allow-list |
| ManiListRow | v1 | avatar/title/subtitle/value/status |
| ManiKPITile | v1 | highlighted variant |
| ManiAppBar | v1 | |
| ManiSearchField | v1 | |
| ManiBottomTabs | v1 | circular (Clean) / square (Bold) center action |
| ManiActionBar | v1 | the spec's "CartBar" |
| ManiToggleRow | v1 | lock state |
| ManiNote | v1 | info/warning/error banner |
| ManiBreakdownRow | v1 | normal/total emphasis |
| ManiItemTile | v1 | POS product tile, qty +/- |
| Keypad | v2 (deferred) | polish only; standard input suffices for now |
| Chart card | v2 (deferred) | needs a Charts-vs-Canvas decision + unconfirmed Skip/Android support |
| Permission matrix | v2 (deferred) | admin-only, out of scope |
| Time slot | v2 (deferred) | no billing use case yet |
| Font-family download/caching | not in scope | app-level networking/caching concern; `ManiTypography.fontFamilyOverride` seam exists for it |

`Gallery/ManiComponentGallery.swift` showcases every component across Clean/Bold × light/dark via `#Preview` — use it as the manual QA loop; there is no automated UI test target.

## Usage conventions

- Every public type/component is prefixed `Mani`.
- New component → own subfolder under `Components/`, reads styling only from `@Environment(\.maniTheme)`, never a hardcoded `Color`.
- New theme preset → add to `Theme/Presets/`, expose via `public extension ManiTheme where Self == YourThemeType { static var yourPreset: YourThemeType { ... } }` (this `Self ==` form, not a plain extension on the concrete type, is required for `.yourPreset` leading-dot syntax to work at `.maniTheme(.yourPreset)` call sites).
- Update the component inventory table above when a component's status changes.

## Skip / Android portability rules

Because the first consumer transpiles through Skip to Kotlin/Compose, and future consumers may too:

- **No `import UIKit`, no `UIColor`, no `Color(uiColor:)`.** Build colors only from `Color(red:green:blue:)` (see `maniColor(_:_:_:)` in `Theme/ManiColorTokens.swift`).
- **No `.onTapGesture` as a button substitute.** Use real `Button`.
- Avoid `#if os(iOS)` escape hatches that have no Compose-side equivalent; where a UIKit-only type is unavoidable (e.g. `UIKeyboardType`), wrap it behind a portable enum and guard the UIKit use with `#if canImport(UIKit)` (see `ManiKeyboardKind`).
- Icons go through `ManiIconName` (SF Symbol names) + `IconView`, not raw asset images — Skip/SkipFuseUI maps SF Symbols to Material Symbols on Android. There is no confirmed list of exactly which symbols map cleanly; validate new `ManiIconName` cases against an actual Android build before relying on them.

## Theming-extension guide for consumers (e.g. apoorva-skip's `ApoorvaUI`)

1. Define your own `ManiTheme` conformance (or reuse a shipped preset) per brand/vertical.
2. In your app's own theme store, implement your resolution policy (org lock, user preference, store/org/vertical defaults, etc.) and expose the resolved `(theme, style)` as `@Observable` state.
3. Apply `.maniTheme(resolvedTheme, style: resolvedStyle)` once at your root view. Because it's driven by `@Observable` state, SwiftUI re-resolves and re-applies automatically whenever your store's resolution changes — no extra plumbing needed in this package.
4. Everything downstream — every `Mani*` component — just works, in both light and dark mode, without knowing about your app's resolution rules.
