![Mediator](https://github.com/user-attachments/assets/5719db2b-d584-4ae7-a9b0-1d16deb1285d)

<br />

# Mediator

> Define an object that encapsulates how a set of objects interact. Mediator promotes loose coupling by keeping objects from referring to each other explicitly, and it lets you vary their interaction independently.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Mediator pattern is used to coordinate communication between multiple related objects in a system.

- It defines a protocol that encapsulates how a set of objects interact.

- This promotes loose coupling by keeping objects from referring to each other directly and centralising communication logic in one place.

## Problem statement

When configuring a **MacBook** for purchase on the Apple Store, there are multiple components that must stay in sync:

1. **Product Configuration** – handles the user’s selections (processor, memory, storage).
2. **Price Summary** – recalculates total price and taxes.
3. **Delivery Estimator** – updates delivery times based on selected configuration.

If these components communicate directly, the result is tight coupling and hard-to-maintain code.

A **Mediator** coordinates communication between the configuration, summary, and delivery components. When the user changes an option, the mediator updates the price and delivery estimate, keeping everything consistent without the components knowing about each other.

## Definitions

#### Mediator protocol

Defines the communication contract that all participating components use to interact indirectly.

```swift
protocol ProductMediating: AnyObject {
    func configurationDidChange(price: Decimal, deliveryDays: Int)
}
```

#### Concrete mediator

Implements `ProductMediating` and coordinates the flow of information and logic between the components.

```swift
final class ProductMediator: ProductMediating {
    private let configurationViewModel: ProductConfigurationViewModel
    private let summaryViewModel: ProductSummaryViewModel
    private let deliveryViewModel: DeliveryEstimatorViewModel

    init(configurationViewModel: ProductConfigurationViewModel,
         summaryViewModel: ProductSummaryViewModel,
         deliveryViewModel: DeliveryEstimatorViewModel) {
        self.configurationViewModel = configurationViewModel
        self.summaryViewModel = summaryViewModel
        self.deliveryViewModel = deliveryViewModel
        configurationViewModel.mediator = self
    }

    func configurationDidChange(price: Decimal, deliveryDays: Int) {
        summaryViewModel.updateTotal(to: price)
        deliveryViewModel.updateEstimate(days: deliveryDays)
    }
}
```

#### Colleagues

The individual components that communicate exclusively through the mediator rather than directly with each other.

```swift
final class ProductConfigurationViewModel {
    weak var mediator: ProductMediating?

    func userSelectedConfiguration(price: Decimal, deliveryDays: Int) {
        mediator?.configurationDidChange(price: price, deliveryDays: deliveryDays)
    }
}

final class ProductSummaryViewModel {
    private(set) var total: Decimal = 0

    func updateTotal(to total: Decimal) {
        self.total = total
    }
}

final class DeliveryEstimatorViewModel {
    private(set) var deliveryEstimate: String = "N/A"

    func updateEstimate(days: Int) {
        deliveryEstimate = "\(days)-day delivery"
    }
}
```

## Example

```swift
let configVM = ProductConfigurationViewModel()
let summaryVM = ProductSummaryViewModel()
let deliveryVM = DeliveryEstimatorViewModel()
let mediator = ProductMediator(configurationViewModel: configVM,
                               summaryViewModel: summaryVM,
                               deliveryViewModel: deliveryVM)

// Initial values
print(summaryVM.total)             // 0
print(deliveryVM.deliveryEstimate) // "N/A"

// User updates configuration
configVM.userSelectedConfiguration(price: 2599.99, deliveryDays: 3)

// Outputs after mediator coordination
print(summaryVM.total)             // 2599.99
print(deliveryVM.deliveryEstimate) // "3-day delivery"
```