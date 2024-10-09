// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleStoreAdapter",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AppleStoreAdapter",
            targets: ["AppleStoreAdapter"]),
    ],
    targets: [
        .target(
            name: "AppleStoreAdapter"),
        .testTarget(
            name: "AppleStoreAdapterTests",
            dependencies: ["AppleStoreAdapter"]
        ),
    ]
)
