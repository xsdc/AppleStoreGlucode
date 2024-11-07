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
    .package(path: "../DesignPatterns/AppleStoreAbstractFactory"),
    .package(path: "../DesignPatterns/AppleStoreAdapter"),
    .package(path: "../DesignPatterns/AppleStoreBridge"),
    .package(path: "../DesignPatterns/AppleStoreBuilder"),
    .package(path: "../DesignPatterns/AppleStoreChainOfResponsibility"),
    .package(path: "../DesignPatterns/AppleStoreCommand"),
    .package(path: "../DesignPatterns/AppleStoreComposite"),
    .package(path: "../DesignPatterns/AppleStoreDecorator"),
    .package(path: "../DesignPatterns/AppleStoreFacade"),
    .package(path: "../DesignPatterns/AppleStoreFactoryMethod"),
    .package(path: "../DesignPatterns/AppleStoreIterator"),
    .package(path: "../DesignPatterns/AppleStoreMediator"),
    .package(path: "../DesignPatterns/AppleStoreMemento"),
    .package(path: "../DesignPatterns/AppleStoreObserver"),
    .package(path: "../DesignPatterns/AppleStorePrototype"),
    .package(path: "../DesignPatterns/AppleStoreProxy"),
    .package(path: "../DesignPatterns/AppleStoreSingleton"),
    .package(path: "../DesignPatterns/AppleStoreState"),
    .package(path: "../DesignPatterns/AppleStoreStrategy"),
    .package(path: "../DesignPatterns/AppleStoreTemplateMethod"),
    .package(path: "../DesignPatterns/AppleStoreVisitor"),
    .package(path: "../OtherPatterns")
]

package.targets = [
    .target(name: "AppleStore",
        dependencies: [
            .product(name: "AppleStoreAbstractFactory", package: "AppleStoreAbstractFactory"),
            .product(name: "AppleStoreAdapter", package: "AppleStoreAdapter"),
            .product(name: "AppleStoreBridge", package: "AppleStoreBridge"),
            .product(name: "AppleStoreBuilder", package: "AppleStoreBuilder"),
            .product(name: "AppleStoreChainOfResponsibility", package: "AppleStoreChainOfResponsibility"),
            .product(name: "AppleStoreCommand", package: "AppleStoreCommand"),
            .product(name: "AppleStoreComposite", package: "AppleStoreComposite"),
            .product(name: "AppleStoreDecorator", package: "AppleStoreDecorator"),
            .product(name: "AppleStoreFacade", package: "AppleStoreFacade"),
            .product(name: "AppleStoreFactoryMethod", package: "AppleStoreFactoryMethod"),
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
            .product(name: "OtherPatterns", package: "OtherPatterns")
        ]
    )
]

package.platforms = [
    .iOS("17.0"),
    .macOS("14.0")
]
