// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "OtherPatterns",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "OtherPatterns",
            targets: ["Sources"]),
    ],
    targets: [
        .target(
            name: "Sources"),
        .testTarget(
            name: "Tests",
            dependencies: ["Sources"]
        ),
    ]
)
