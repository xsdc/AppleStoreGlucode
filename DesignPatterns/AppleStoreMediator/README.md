![Mediator](https://github.com/user-attachments/assets/5719db2b-d584-4ae7-a9b0-1d16deb1285d)

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
protocol TotalUpdateHandler {
    func totalUpdated(to total: Double)
}
```

#### Concrete mediators:

- Knows and maintains its colleagues.

- Facilitates communication between them by implementing the `TotalUpdateHandler` protocol.

```swift
class ProductView: TotalUpdateHandler {
    private let configurationViewModel: ProductConfigurationViewModel
    private let summaryViewModel: ProductSummaryViewModel

    init(configurationViewModel: ProductConfigurationViewModel, summaryViewModel: ProductSummaryViewModel) {
        self.configurationViewModel = configurationViewModel
        self.summaryViewModel = summaryViewModel
        self.configurationViewModel.delegate = self
    }

    func totalUpdated(to total: Double) {
        summaryViewModel.updateTotal(to: total)
    }
}
```

#### Colleague classes:

- They maintain a reference to their Mediator object if they need to communicate with other Colleague objects.

- In our case, we have one way communication from the `ProductConfigurationViewModel` to the `ProductSummaryViewModel`.

- The `ProductConfigurationViewModel` calls the `totalUpdated(to:)` method on the `TotalUpdateHandler` protocol.

- In our case, that is implemented by the `ProductView` class.

- The `ProductView` then calls the `updateTotal(to:)` method on the `ProductSummaryViewModel`.

```swift
class ProductSummaryViewModel {
    private(set) var total: Double

    init(total: Double, deliveryEstimate: String) {
        self.total = total
    }

    func updateTotal(to total: Double) {
        self.total = total
    }
}

class ProductConfigurationViewModel {
    var delegate: TotalUpdateHandler?

    func configurationDidChange(withTotal total: Double) {
        delegate?.totalUpdated(to: total)
    }
}
```

## Example

```swift
let configurationViewModel = ProductConfigurationViewModel()
let summaryViewModel = ProductSummaryViewModel(total: 999.99, deliveryEstimate: "1-2 days")
let productView = ProductView(configurationViewModel: configurationViewModel, summaryViewModel: summaryViewModel)

// Initial price
print(summaryViewModel.total) // 999.99

// Update price via the configuration view
configurationViewModel.configurationDidChange(withTotal: 1099.99)

// New price should be reflected in the summary view
print(summaryViewModel.total) // 1099.99
```
