// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleStoreChainOfResponsibility",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AppleStoreChainOfResponsibility",
            targets: ["AppleStoreChainOfResponsibility"]),
    ],
    targets: [
        .target(
            name: "AppleStoreChainOfResponsibility"),
        .testTarget(
            name: "AppleStoreChainOfResponsibilityTests",
            dependencies: ["AppleStoreChainOfResponsibility"]
        ),
    ]
)
