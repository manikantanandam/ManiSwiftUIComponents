import SwiftUI

public struct ManiChartDatum: Identifiable, Sendable {
    public let id = UUID()
    public let label: String
    public let value: Double

    public init(_ label: String, _ value: Double) {
        self.label = label
        self.value = value
    }
}

public struct ManiSplitSegment: Identifiable, Sendable {
    public let id = UUID()
    public let label: String
    public let value: Double

    public init(_ label: String, _ value: Double) {
        self.label = label
        self.value = value
    }
}

/// Card wrapper shared by the chart components.
private struct ChartCard<Content: View>: View {
    @Environment(\.maniTheme) private var theme
    let title: String
    let caption: String?
    @ViewBuilder let content: Content

    var body: some View {
        ManiCard {
            VStack(alignment: .leading, spacing: ManiSpacing.md) {
                HStack {
                    Text(title)
                        .font(theme.typography.sectionHeader)
                        .foregroundStyle(theme.base.text)
                    Spacer()
                    if let caption {
                        Text(caption)
                            .font(theme.typography.secondary)
                            .foregroundStyle(theme.base.textSecondary)
                    }
                }
                content
            }
        }
    }
}

/// Vertical bars with labels underneath; the tallest bar is solid accent, the rest soft.
public struct ManiBarChartCard: View {
    @Environment(\.maniTheme) private var theme
    private let title: String
    private let caption: String?
    private let bars: [ManiChartDatum]
    private let highlightMax: Bool

    public init(title: String, caption: String? = nil, bars: [ManiChartDatum], highlightMax: Bool = true) {
        self.title = title
        self.caption = caption
        self.bars = bars
        self.highlightMax = highlightMax
    }

    public var body: some View {
        let maxValue = max(bars.map(\.value).max() ?? 0, 1)
        ChartCard(title: title, caption: caption) {
            if bars.isEmpty {
                Text("No data yet")
                    .font(theme.typography.secondary)
                    .foregroundStyle(theme.base.textSecondary)
                    .frame(maxWidth: .infinity, minHeight: 120)
            } else {
                HStack(alignment: .bottom, spacing: ManiSpacing.sm) {
                    ForEach(bars) { bar in
                        VStack(spacing: ManiSpacing.xs) {
                            RoundedRectangle(cornerRadius: 4, style: .continuous)
                                .fill(highlightMax && bar.value == maxValue ? theme.accent.accent : theme.accent.accent.opacity(0.35))
                                .frame(height: max(4, 120 * bar.value / maxValue))
                            Text(bar.label)
                                .font(.system(size: 11))
                                .foregroundStyle(theme.base.textSecondary)
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .frame(height: 140, alignment: .bottom)
            }
        }
    }
}

/// A simple polyline with a soft fill underneath.
public struct ManiLineChartCard: View {
    @Environment(\.maniTheme) private var theme
    private let title: String
    private let caption: String?
    private let values: [Double]

    public init(title: String, caption: String? = nil, values: [Double]) {
        self.title = title
        self.caption = caption
        self.values = values
    }

    public var body: some View {
        ChartCard(title: title, caption: caption) {
            GeometryReader { proxy in
                let points = normalizedPoints(in: proxy.size)
                ZStack {
                    Path { path in
                        guard let first = points.first, let last = points.last else { return }
                        path.move(to: CGPoint(x: first.x, y: proxy.size.height))
                        for point in points { path.addLine(to: point) }
                        path.addLine(to: CGPoint(x: last.x, y: proxy.size.height))
                        path.closeSubpath()
                    }
                    .fill(theme.accent.soft)
                    Path { path in
                        guard let first = points.first else { return }
                        path.move(to: first)
                        for point in points.dropFirst() { path.addLine(to: point) }
                    }
                    .stroke(theme.accent.accent, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                }
            }
            .frame(height: 120)
        }
    }

    private func normalizedPoints(in size: CGSize) -> [CGPoint] {
        guard values.count > 1 else {
            return values.isEmpty ? [] : [CGPoint(x: 0, y: size.height / 2), CGPoint(x: size.width, y: size.height / 2)]
        }
        let maxValue = values.max() ?? 1
        let minValue = values.min() ?? 0
        let range = max(maxValue - minValue, 1)
        return values.enumerated().map { index, value in
            CGPoint(x: size.width * CGFloat(index) / CGFloat(values.count - 1),
                    y: size.height - size.height * 0.9 * CGFloat((value - minValue) / range) - size.height * 0.05)
        }
    }
}

/// One horizontal bar split into proportional segments (e.g. Cash / UPI / Card), with a legend.
public struct ManiSplitBarCard: View {
    @Environment(\.maniTheme) private var theme
    private let title: String
    private let caption: String?
    private let segments: [ManiSplitSegment]

    public init(title: String, caption: String? = nil, segments: [ManiSplitSegment]) {
        self.title = title
        self.caption = caption
        self.segments = segments
    }

    private let opacities: [Double] = [1, 0.55, 0.28, 0.15]

    public var body: some View {
        let total = max(segments.reduce(0) { $0 + $1.value }, 0.0001)
        ChartCard(title: title, caption: caption) {
            GeometryReader { proxy in
                HStack(spacing: 2) {
                    ForEach(Array(segments.enumerated()), id: \.element.id) { index, segment in
                        Rectangle()
                            .fill(theme.accent.accent.opacity(opacities[index % opacities.count]))
                            .frame(width: max(0, proxy.size.width * segment.value / total - 2))
                    }
                }
            }
            .frame(height: 12)
            .clipShape(Capsule())

            VStack(alignment: .leading, spacing: ManiSpacing.xs) {
                ForEach(Array(segments.enumerated()), id: \.element.id) { index, segment in
                    HStack(spacing: ManiSpacing.sm) {
                        Circle()
                            .fill(theme.accent.accent.opacity(opacities[index % opacities.count]))
                            .frame(width: 8, height: 8)
                        Text(segment.label)
                            .font(theme.typography.secondary)
                            .foregroundStyle(theme.base.text)
                        Spacer()
                        Text("\(Int((segment.value / total * 100).rounded()))%")
                            .font(theme.typography.secondary.monospacedDigit())
                            .foregroundStyle(theme.base.textSecondary)
                    }
                }
            }
        }
    }
}
