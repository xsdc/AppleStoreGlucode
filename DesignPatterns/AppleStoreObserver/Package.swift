// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleStoreObserver",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AppleStoreObserver",
            targets: ["AppleStoreObserver"]),
    ],
    targets: [
        .target(
            name: "AppleStoreObserver"),
        .testTarget(
            name: "AppleStoreObserverTests",
            dependencies: ["AppleStoreObserver"]
        ),
    ]
)
