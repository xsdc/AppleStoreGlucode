// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleStoreFacade",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AppleStoreFacade",
            targets: ["AppleStoreFacade"]),
    ],
    targets: [
        .target(
            name: "AppleStoreFacade"),
        .testTarget(
            name: "AppleStoreFacadeTests",
            dependencies: ["AppleStoreFacade"]
        ),
    ]
)
