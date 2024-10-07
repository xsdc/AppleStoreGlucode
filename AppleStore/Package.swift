// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppleStore",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "AppleStore",
            targets: ["AppleStore"]),
    ],
    targets: [
        .target(
            name: "AppleStore"),
        .testTarget(
            name: "AppleStoreTests",
            dependencies: ["AppleStore"]
        ),
    ]
)

package.dependencies = [
    .package(path: "../AppleStoreAdapter"),
    .package(path: "../AppleStoreBridge"),
    .package(path: "../AppleStoreBuilder"),
    .package(path: "../AppleStoreChainOfResponsibility"),
    .package(path: "../AppleStoreCommand"),
    .package(path: "../AppleStoreComposite"),
    .package(path: "../AppleStoreDecorator"),
    .package(path: "../AppleStoreFacade"),
    .package(path: "../AppleStoreFactory"),
    .package(path: "../AppleStoreFlyweight"),
    .package(path: "../AppleStoreIterator"),
    .package(path: "../AppleStoreMediator"),
    .package(path: "../AppleStoreMemento"),
    .package(path: "../AppleStoreObserver"),
    .package(path: "../AppleStorePrototype"),
    .package(path: "../AppleStoreProxy"),
    .package(path: "../AppleStoreSingleton"),
    .package(path: "../AppleStoreState"),
    .package(path: "../AppleStoreStrategy"),
    .package(path: "../AppleStoreTemplateMethod"),
    .package(path: "../AppleStoreVisitor"),
]
package.targets = [
    .target(name: "AppleStore",
        dependencies: [
            .product(name: "AppleStoreAdapter", package: "AppleStoreAdapter"),
            .product(name: "AppleStoreBridge", package: "AppleStoreBridge"),
            .product(name: "AppleStoreBuilder", package: "AppleStoreBuilder"),
            .product(name: "AppleStoreChainOfResponsibility", package: "AppleStoreChainOfResponsibility"),
            .product(name: "AppleStoreCommand", package: "AppleStoreCommand"),
            .product(name: "AppleStoreComposite", package: "AppleStoreComposite"),
            .product(name: "AppleStoreDecorator", package: "AppleStoreDecorator"),
            .product(name: "AppleStoreFacade", package: "AppleStoreFacade"),
            .product(name: "AppleStoreFactory", package: "AppleStoreFactory"),
            .product(name: "AppleStoreFlyweight", package: "AppleStoreFlyweight"),
            .product(name: "AppleStoreIterator", package: "AppleStoreIterator"),
            .product(name: "AppleStoreMediator", package: "AppleStoreMediator"),
            .product(name: "AppleStoreMemento", package: "AppleStoreMemento"),
            .product(name: "AppleStoreObserver", package: "AppleStoreObserver"),
            .product(name: "AppleStorePrototype", package: "AppleStorePrototype"),
            .product(name: "AppleStoreProxy", package: "AppleStoreProxy"),
            .product(name: "AppleStoreSingleton", package: "AppleStoreSingleton"),
            .product(name: "AppleStoreState", package: "AppleStoreState"),
            .product(name: "AppleStoreStrategy", package: "AppleStoreStrategy"),
            .product(name: "AppleStoreTemplateMethod", package: "AppleStoreTemplateMethod"),
            .product(name: "AppleStoreVisitor", package: "AppleStoreVisitor"),
        ]
    )
]
package.platforms = [
    .iOS("17.0"),
    .macOS("14.0")
]
