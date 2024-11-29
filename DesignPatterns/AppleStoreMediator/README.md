![Mediator](https://github.com/user-attachments/assets/3c84efaa-f222-4a39-a647-9cf0b220a394)

<br />

# Mediator

> Define an object that encapsulates how a set of objects interact. Mediator promotes loose coupling by keeping objects from referring to each other explicitly, and it lets you vary their interaction independently.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Mediator pattern is used to facilitate communication between objects in a system.

- It defines a protocol that encapsulates how a set of objects interact.

- This promotes loose coupling by keeping objects from referring to each other explicitly.

## Problem statement

- When configuring a MacBook for purchase on the Apple Store, two components are present: the product configuration and the product price summary.

- The product configuration is a part of the main body of the view, and the product summary is a footer that displays the total price of the product, among other details.

- If all the functionality for both the product configuration and the product summary is contained in a single view, it can lead to a large and complex view.

- While communicatio between object may be easier, it can lead to tight coupling between the two components.

- Instead, we want a modular design that allows for decoupling of the product configuration and the product summary.

- The Mediator pattern facilitates communication between the product configuration and the product summary while keeping them decoupled.

## Definitions

#### Mediator:

- Defines the protocol we'll use to communicate price updates between the product configuration and the product summary.

```swift
protocol PriceUpdating {
    func totalChanged(toPrice total: Double)
}
```

#### Concrete mediators:

- Knows and maintains its colleagues.

- Facilitates communication between them by implementing the `PriceUpdating` protocol.

```swift
class ProductView: PriceUpdating {
    private let configurationView: ProductConfigurationView
    private let summaryView: ProductSummaryView

    init(configurationView: ProductConfigurationView, summaryView: ProductSummaryView) {
        self.configurationView = configurationView
        self.summaryView = summaryView
        self.configurationView.assignPriceUpdater(self)
    }

    func totalChanged(toPrice total: Double) {
        summaryView.updateTotal(toPrice: total)
    }
}
```

#### Colleague classes:

- They maintain a reference to their Mediator object if they need to communicate with other Colleague objects.

- In our case, we have one way communication from the `ProductConfigurationView` to the `ProductSummaryView`.

- The `ProductConfigurationView` calls the `totalChanged(toPrice:)` method on the `PriceUpdating` protocol.

- In our case, that is implemented by the `ProductView` class.

- The `ProductView` then calls the `updateTotal(toPrice:)` method on the `ProductSummaryView`.

```swift
class ProductSummaryView {
    private(set) var price: Double

    init(price: Double, deliveryEstimate: String) {
        self.price = price
    }

    func updateTotal(toPrice price: Double) {
        self.price = price
    }
}

class ProductConfigurationView {
    private var priceUpdater: PriceUpdating?

    func assignPriceUpdater(_ priceUpdater: PriceUpdating) {
        self.priceUpdater = priceUpdater
    }

    func configurationChanged(withPrice price: Double) {
        priceUpdater?.totalChanged(toPrice: price)
    }
}
```

## Example

```swift
let configurationView = ProductConfigurationView()
let summaryView = ProductSummaryView(price: 999.99, deliveryEstimate: "1-2 days")
let productView = ProductView(configurationView: configurationView, summaryView: summaryView)

// Initial price
print(summaryView.price) // 999.99

// Update price via the configuration view
configurationView.configurationChanged(withPrice: 1099.99)

// New price should be reflected in the summary view
print(summaryView.price) // 1099.99
```
