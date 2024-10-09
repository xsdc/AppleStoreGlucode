// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleStoreVisitor",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AppleStoreVisitor",
            targets: ["AppleStoreVisitor"]),
    ],
    targets: [
        .target(
            name: "AppleStoreVisitor"),
        .testTarget(
            name: "AppleStoreVisitorTests",
            dependencies: ["AppleStoreVisitor"]
        ),
    ]
)
