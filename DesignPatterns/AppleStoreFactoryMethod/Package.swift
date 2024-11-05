// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleStoreFactory",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AppleStoreFactory",
            targets: ["AppleStoreFactory"]),
    ],
    targets: [
        .target(
            name: "AppleStoreFactory"),
        .testTarget(
            name: "AppleStoreFactoryTests",
            dependencies: ["AppleStoreFactory"]
        ),
    ]
)
