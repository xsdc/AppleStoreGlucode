// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleStoreMediator",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AppleStoreMediator",
            targets: ["AppleStoreMediator"]),
    ],
    targets: [
        .target(
            name: "AppleStoreMediator"),
        .testTarget(
            name: "AppleStoreMediatorTests",
            dependencies: ["AppleStoreMediator"]
        ),
    ]
)
