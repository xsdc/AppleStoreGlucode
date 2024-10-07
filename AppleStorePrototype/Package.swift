// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleStorePrototype",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AppleStorePrototype",
            targets: ["AppleStorePrototype"]),
    ],
    targets: [
        .target(
            name: "AppleStorePrototype"),
        .testTarget(
            name: "AppleStorePrototypeTests",
            dependencies: ["AppleStorePrototype"]
        ),
    ]
)
