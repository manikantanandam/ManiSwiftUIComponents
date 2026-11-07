// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "ManiSwiftUIComponents",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        .library(
            name: "ManiSwiftUIComponents",
            targets: ["ManiSwiftUIComponents"]
        ),
    ],
    targets: [
        .target(
            name: "ManiSwiftUIComponents",
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ]
        ),
    ]
)
