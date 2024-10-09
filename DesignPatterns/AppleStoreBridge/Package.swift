// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleStoreBridge",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AppleStoreBridge",
            targets: ["AppleStoreBridge"]),
    ],
    targets: [
        .target(
            name: "AppleStoreBridge"),
        .testTarget(
            name: "AppleStoreBridgeTests",
            dependencies: ["AppleStoreBridge"]
        ),
    ]
)
