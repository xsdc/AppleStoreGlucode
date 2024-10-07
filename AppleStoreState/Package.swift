// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleStoreState",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AppleStoreState",
            targets: ["AppleStoreState"]),
    ],
    targets: [
        .target(
            name: "AppleStoreState"),
        .testTarget(
            name: "AppleStoreStateTests",
            dependencies: ["AppleStoreState"]
        ),
    ]
)
