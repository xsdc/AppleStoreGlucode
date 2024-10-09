// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleStoreStrategy",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AppleStoreStrategy",
            targets: ["AppleStoreStrategy"]),
    ],
    targets: [
        .target(
            name: "AppleStoreStrategy"),
        .testTarget(
            name: "AppleStoreStrategyTests",
            dependencies: ["AppleStoreStrategy"]
        ),
    ]
)
