<br />

# Mediator

> Define an object that encapsulates how a set of objects interact. Mediator promotes loose coupling by keeping objects from referring to each other explicitly, and it lets you vary their interaction independently.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The mediator pattern defines an object that encapsulates how a set of objects interact.
- It promotes loose coupling by keeping objects from referring to each other explicitly, and it lets you vary their interaction independently.
- For example, in a messaging application, the mediator object can manager the list of users and their messages.

## Problem overview

- On a product page, we would like to keep the product price summary in sync with the product configuration.
- The product configuration can be updated by the user, and the product price summary should be updated accordingly.

## Domain application

Mediator:

Defines an interface for communicating with Colleague objects.

```swift
protocol ConfigurationManager {
    func displayTypeChanged(_ type: String)
    func chipTypeChanged(_ type: String)
    func memoryTypeChanged(_ type: String)
    func storageTypeChanged(_ type: String)
}
```

ConcreteMediator:

- Implements cooperative behavior by coordinating Colleague objects.
- Knows and maintains its colleagues.

```swift
class MacBookProProduct: ConfigurationManager {
    let productConfiguration: ProductConfiguration
    let productPriceSummary: ProductPriceSummary

    init(bag: Bag, catalog: Catalog) {
        self.bag = bag
        self.catalog = catalog
    }

    func displayTypeChanged(_ type: String) {
        productPriceSummary.updateDisplayType(type)
    }

    func chipTypeChanged(_ type: String) {
        productPriceSummary.updateChipType(type)
    }

    func memoryTypeChanged(_ type: String) {
        productPriceSummary.updateMemoryType(type)
    }

    func storageTypeChanged(_ type: String) {
        productPriceSummary.updateStorageType(type)
    }
}
```

Colleague classes:

- Each Colleague class knows its Mediator object.
- Each colleague communicates with its mediator whenever it would have otherwise communicated with another colleague.

```swift
class ProductPriceSummary {
    let configurationManager: ConfigurationManager

    init(configurationManager: ConfigurationManager) {
        self.configurationManager = configurationManager
    }

    func updateDisplayType(_ type: String) {
        // Update display type
    }

    func updateChipType(_ type: String) {
        // Update chip type
    }

    func updateMemoryType(_ type: String) {
        // Update memory type
    }

    func updateStorageType(_ type: String) {
        // Update storage type
    }
}

class ProductConfiguration {
    let configurationManager: ConfigurationManager

    init(configurationManager: ConfigurationManager) {
        self.configurationManager = configurationManager
    }

    func displayTypeChanged(_ type: String) {
        configurationManager.displayTypeChanged(type)
    }

    func chipTypeChanged(_ type: String) {
        configurationManager.chipTypeChanged(type)
    }

    func memoryTypeChanged(_ type: String) {
        configurationManager.memoryTypeChanged(type)
    }

    func storageTypeChanged(_ type: String) {
        configurationManager.storageTypeChanged(type)
    }
}
```
