// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleStoreIterator",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AppleStoreIterator",
            targets: ["AppleStoreIterator"]),
    ],
    targets: [
        .target(
            name: "AppleStoreIterator"),
        .testTarget(
            name: "AppleStoreIteratorTests",
            dependencies: ["AppleStoreIterator"]
        ),
    ]
)
