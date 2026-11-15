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
    dependencies: [
        .package(url: "https://github.com/skiptools/skip-fuse-ui.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "ManiSwiftUIComponents",
            dependencies: [
                // Supplies the `SwiftUI` module on Android (see skip-fuse-ui's `SwiftUI` shim target).
                .product(name: "SkipFuseUI", package: "skip-fuse-ui", condition: .when(platforms: [.android])),
            ],
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ]
        ),
    ]
)
