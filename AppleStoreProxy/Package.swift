// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleStoreProxy",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AppleStoreProxy",
            targets: ["AppleStoreProxy"]),
    ],
    targets: [
        .target(
            name: "AppleStoreProxy"),
        .testTarget(
            name: "AppleStoreProxyTests",
            dependencies: ["AppleStoreProxy"]
        ),
    ]
)
