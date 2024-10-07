// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleStoreDecorator",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AppleStoreDecorator",
            targets: ["AppleStoreDecorator"]),
    ],
    targets: [
        .target(
            name: "AppleStoreDecorator"),
        .testTarget(
            name: "AppleStoreDecoratorTests",
            dependencies: ["AppleStoreDecorator"]
        ),
    ]
)
