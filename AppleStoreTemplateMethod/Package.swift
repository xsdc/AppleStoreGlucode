// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleStoreTemplateMethod",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AppleStoreTemplateMethod",
            targets: ["AppleStoreTemplateMethod"]),
    ],
    targets: [
        .target(
            name: "AppleStoreTemplateMethod"),
        .testTarget(
            name: "AppleStoreTemplateMethodTests",
            dependencies: ["AppleStoreTemplateMethod"]
        ),
    ]
)
