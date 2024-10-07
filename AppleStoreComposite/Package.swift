// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleStoreComposite",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AppleStoreComposite",
            targets: ["AppleStoreComposite"]),
    ],
    targets: [
        .target(
            name: "AppleStoreComposite"),
        .testTarget(
            name: "AppleStoreCompositeTests",
            dependencies: ["AppleStoreComposite"]
        ),
    ]
)
