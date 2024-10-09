// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleStoreCommand",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AppleStoreCommand",
            targets: ["AppleStoreCommand"]),
    ],
    targets: [
        .target(
            name: "AppleStoreCommand"),
        .testTarget(
            name: "AppleStoreCommandTests",
            dependencies: ["AppleStoreCommand"]
        ),
    ]
)
