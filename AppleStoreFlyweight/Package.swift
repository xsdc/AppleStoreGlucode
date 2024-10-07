// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleStoreFlyweight",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AppleStoreFlyweight",
            targets: ["AppleStoreFlyweight"]),
    ],
    targets: [
        .target(
            name: "AppleStoreFlyweight"),
        .testTarget(
            name: "AppleStoreFlyweightTests",
            dependencies: ["AppleStoreFlyweight"]
        ),
    ]
)
