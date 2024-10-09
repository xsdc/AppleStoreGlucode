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
    .package(path: "../AppleStoreDesignPatterns/AppleStoreAdapter"),
    .package(path: "../AppleStoreDesignPatterns/AppleStoreBridge"),
    .package(path: "../AppleStoreDesignPatterns/AppleStoreBuilder"),
    .package(path: "../AppleStoreDesignPatterns/AppleStoreChainOfResponsibility"),
    .package(path: "../AppleStoreDesignPatterns/AppleStoreCommand"),
    .package(path: "../AppleStoreDesignPatterns/AppleStoreComposite"),
    .package(path: "../AppleStoreDesignPatterns/AppleStoreDecorator"),
    .package(path: "../AppleStoreDesignPatterns/AppleStoreFacade"),
    .package(path: "../AppleStoreDesignPatterns/AppleStoreFactory"),
    .package(path: "../AppleStoreDesignPatterns/AppleStoreFlyweight"),
    .package(path: "../AppleStoreDesignPatterns/AppleStoreIterator"),
    .package(path: "../AppleStoreDesignPatterns/AppleStoreMediator"),
    .package(path: "../AppleStoreDesignPatterns/AppleStoreMemento"),
    .package(path: "../AppleStoreDesignPatterns/AppleStoreObserver"),
    .package(path: "../AppleStoreDesignPatterns/AppleStorePrototype"),
    .package(path: "../AppleStoreDesignPatterns/AppleStoreProxy"),
    .package(path: "../AppleStoreDesignPatterns/AppleStoreSingleton"),
    .package(path: "../AppleStoreDesignPatterns/AppleStoreState"),
    .package(path: "../AppleStoreDesignPatterns/AppleStoreStrategy"),
    .package(path: "../AppleStoreDesignPatterns/AppleStoreTemplateMethod"),
    .package(path: "../AppleStoreDesignPatterns/AppleStoreVisitor"),
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
