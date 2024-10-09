// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleStoreMemento",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AppleStoreMemento",
            targets: ["AppleStoreMemento"]),
    ],
    targets: [
        .target(
            name: "AppleStoreMemento"),
        .testTarget(
            name: "AppleStoreMementoTests",
            dependencies: ["AppleStoreMemento"]
        ),
    ]
)
