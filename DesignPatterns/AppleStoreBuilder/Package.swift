// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleStoreBuilder",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AppleStoreBuilder",
            targets: ["AppleStoreBuilder"]),
    ],
    targets: [
        .target(
            name: "AppleStoreBuilder"),
        .testTarget(
            name: "AppleStoreBuilderTests",
            dependencies: ["AppleStoreBuilder"]
        ),
    ]
)
