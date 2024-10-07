// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleStoreSingleton",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AppleStoreSingleton",
            targets: ["AppleStoreSingleton"]),
    ],
    targets: [
        .target(
            name: "AppleStoreSingleton"),
        .testTarget(
            name: "AppleStoreSingletonTests",
            dependencies: ["AppleStoreSingleton"]
        ),
    ]
)
