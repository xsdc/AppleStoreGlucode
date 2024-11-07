// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleStoreFactoryMethod",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AppleStoreFactoryMethod",
            targets: ["AppleStoreFactoryMethod"]),
    ],
    targets: [
        .target(
            name: "AppleStoreFactoryMethod"),
        .testTarget(
            name: "AppleStoreFactoryMethodTests",
            dependencies: ["AppleStoreFactoryMethod"]
        ),
    ]
)
