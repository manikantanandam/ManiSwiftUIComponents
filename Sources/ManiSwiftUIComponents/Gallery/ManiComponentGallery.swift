import SwiftUI

/// A scrollable showcase of every component, for manual QA in Xcode
/// Previews across themes/styles/color schemes. Not part of the public
/// component surface a consumer app would ship.
struct ManiComponentGallery: View {
    @State private var text = ""
    @State private var toggleOn = true
    @State private var segment = "cash"
    @State private var filter: String?
    @State private var tabSelection = 0
    @State private var cashAmount = "583"
    @State private var keypadText = "250"
    @State private var pick = "fancy"
    @State private var swatch = "plum"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ManiSpacing.lg) {
                ManiAppBar(title: "Component Gallery")

                ManiCard {
                    VStack(alignment: .leading, spacing: ManiSpacing.sm) {
                        ManiButton("Collect ₹583", action: {})
                        ManiButton("Hold bill", kind: .outline, action: {})
                        ManiButton("Loading…", isLoading: true, action: {})
                    }
                }

                ManiInputField(label: "Customer name", text: $text, placeholder: "e.g. Priya")

                ManiChipGroup(
                    items: ["Today", "Yesterday", "This week", "Unpaid"],
                    label: { $0 },
                    selection: $filter
                )

                ManiSegmentedControl(
                    selection: $segment,
                    options: [("cash", "Cash"), ("upi", "UPI"), ("card", "Card"), ("credit", "Credit")]
                )

                ManiCard {
                    VStack(spacing: ManiSpacing.sm) {
                        ManiBreakdownRow(label: "Subtotal", value: "₹560")
                        ManiBreakdownRow(label: "Discount", value: "-₹23")
                        ManiBreakdownRow(label: "Total", value: "₹583", emphasis: .total)
                    }
                }

                HStack(spacing: ManiSpacing.sm) {
                    ManiKPITile(title: "Today", value: "₹12,400", isHighlighted: true)
                    ManiKPITile(title: "Bills", value: "46")
                }

                ManiCard {
                    VStack(spacing: 0) {
                        ManiListRow(
                            avatar: ManiAvatar(initials: "PR"),
                            title: "Priya Rao",
                            subtitle: "#1042 · 2:40 PM",
                            value: "₹583",
                            status: ("Paid", .success)
                        )
                        ManiListRow(
                            avatar: ManiAvatar(initials: "AK"),
                            title: "Arjun Kumar",
                            subtitle: "#1041 · 1:15 PM",
                            value: "₹1,120",
                            status: ("Due", .warning)
                        )
                    }
                }

                ManiToggleRow(title: "Allow partial payment", isOn: $toggleOn)
                ManiToggleRow(title: "Tax inclusive pricing", isOn: $toggleOn, isLocked: true)

                ManiNote("Bills older than 30 days can't be edited.")

                ManiItemTile(
                    title: "Basmati Rice 1kg",
                    priceText: "₹120",
                    quantity: 2,
                    onIncrement: {},
                    onDecrement: {}
                )

                ManiActionBar(
                    summaryText: "3 items",
                    primaryTitle: "Collect ₹583",
                    primaryAction: {},
                    secondaryTitle: "Hold bill",
                    secondaryAction: {}
                )

                HStack(spacing: ManiSpacing.sm) {
                    ManiCategoryTile(title: "Bangles", isHotkey: true, action: {})
                    ManiCategoryTile(title: "Earrings", action: {})
                }

                ManiCartLineRow(
                    title: "Bangles 12",
                    subtitle: "₹120/unit · 10% off",
                    totalText: "₹216",
                    quantityUnitText: "2 × ₹108",
                    onTap: {},
                    onRemove: {}
                )

                ManiPaymentModeRow(
                    title: "Cash",
                    icon: .cash,
                    isSelected: true,
                    amountText: $cashAmount,
                    onToggle: { _ in }
                )

                ManiStepIndicator(current: 2, total: 4)
                ManiHeroAmount("₹\(keypadText)", caption: "of ₹1,120 due")
                ManiKeypad { keypadText = $0.apply(to: keypadText) }
                ManiCodeField(length: 4, code: "48")
                ManiCodeField(length: 4, code: "48", secure: true)
                ManiKeyValueSummary(rows: [ManiKeyValue("Subtotal", "₹560"), ManiKeyValue("Discount", "-₹23"), ManiKeyValue("Total", "₹583")])
                ManiBarChartCard(title: "Last 7 days", bars: [ManiChartDatum("M", 4), ManiChartDatum("T", 7), ManiChartDatum("W", 5), ManiChartDatum("T", 9)])
                ManiLineChartCard(title: "Sales", caption: "This week", values: [3, 5, 4, 8, 6, 9, 7])
                ManiSplitBarCard(title: "Payment modes", segments: [ManiSplitSegment("Cash", 52), ManiSplitSegment("UPI", 38), ManiSplitSegment("Card", 10)])
                ManiPermissionMatrix(
                    columns: [(value: "owner", title: "Owner"), (value: "cashier", title: "Cashier")],
                    rows: [(value: "discount", title: "Give discount"), (value: "cancel", title: "Cancel bill")],
                    value: { row, column in column == "owner" || row == "discount" },
                    isLocked: { _, column in column == "owner" },
                    onToggle: { _, _ in }
                )
                ManiPickList(options: [
                    ManiPickOption(value: "kirana", title: "Kirana / General", subtitle: "Quick search, loose items", swatch: .teal),
                    ManiPickOption(value: "fancy", title: "Fancy & Gifts", subtitle: "Item grid, variants", swatch: .purple)
                ], selection: $pick)
                ManiSwatchRow(options: [(value: "teal", title: "Teal", color: .teal), (value: "plum", title: "Plum", color: .purple)], selection: $swatch)
                ManiProgressMeter(label: "Free bills this month", value: 82, total: 100)
                ManiProviderButton(provider: .google, title: "Continue with Google", action: {})
                ManiEmptyState(icon: .mail, title: "Check your inbox", message: "We sent a link to verify your email.", actionTitle: "Open mail app", action: {})
                ManiUndoBanner(message: "Saved by mistake? 4:52 left", actionTitle: "Undo bill", action: {})
            }
            .padding(ManiSpacing.lg)
        }
        .safeAreaInset(edge: .bottom) {
            ManiBottomTabs(
                tabs: [
                    ManiTabItem(icon: .home, title: "Home"),
                    ManiTabItem(icon: .bills, title: "Bills"),
                    ManiTabItem(icon: .customers, title: "Customers"),
                    ManiTabItem(icon: .more, title: "More"),
                ],
                selection: $tabSelection,
                centerAction: ManiTabCenterAction(action: {})
            )
        }
    }
}

#Preview("Clean / Light") {
    ManiComponentGallery().maniTheme(.apoorvaInk, style: .clean)
}

#Preview("Bold / Dark") {
    ManiComponentGallery()
        .maniTheme(.apoorvaInk, style: .bold)
        .preferredColorScheme(.dark)
}
