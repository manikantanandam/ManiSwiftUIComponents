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
        .package(url: "https://github.com/skiptools/skip.git", from: "1.9.13"),
        .package(url: "https://github.com/skiptools/skip-fuse-ui.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "ManiSwiftUIComponents",
            dependencies: [
                // Unconditional: skipstone resolves the Kotlin side's dependencies on the host, so an
                // Android-only condition leaves the generated bridge code without `skip.bridge`.
                .product(name: "SkipFuseUI", package: "skip-fuse-ui"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ],
            // skipstone generates the SkipUIBridging conformance custom views need to render on Android
            // (Skip Fuse); without it every Mani* view renders as EmptyView.
            plugins: [.plugin(name: "skipstone", package: "skip")]
        ),
    ]
)
