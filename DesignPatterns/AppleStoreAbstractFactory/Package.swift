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
            name: "AppleStoreAbstractFactory",
            targets: ["AppleStoreAbstractFactory"]),
    ],
    targets: [
        .target(
            name: "AppleStoreAbstractFactory"),
        .testTarget(
            name: "AppleStoreAbstractFactoryTests",
            dependencies: ["AppleStoreAbstractFactory"]
        ),
    ]
)
