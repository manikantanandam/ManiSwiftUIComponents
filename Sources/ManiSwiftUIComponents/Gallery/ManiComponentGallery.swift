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
