![Decorator](https://github.com/user-attachments/assets/79606909-0f77-4fde-af76-6dd43c31ea1c)

<br />

# Decorator

> Attach additional responsibilities to an object dynamically. Decorators provide a flexible alternative to subclassing for extending functionality.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The `Decorator` pattern is a structural pattern that allows adding new behaviors to objects dynamically by placing them inside special wrapper objects that contain these behaviors.
- These can be stacked on top of each other, each time adding a new behavior to the object.
- For example, a service call can be decorated with logging, caching, and authorization behaviors.
- The `Decorator` pattern is an alternative to subclassing. Subclassing adds behavior at compile time, and the change affects all instances of the original class.
- `Decorator` objects can be used to add new behaviors to individual objects at runtime and can be selectively applied.

## Problem statement

- We would like a way to dynamically calculate the price of products based on if student/education discounts apply, or if Apple Care was selected.
- With the Decorator pattern, we can stack classes to calculate the final price of a product based on the selected options.

## Domain application

Component:

Defines the interface for objects that can have responsibilities added to them dynamically.

```swift
protocol Product {
    func getPrice() -> Double
}
```

ConcreteComponent:

Defines an object to which additional responsibilities can be attached.

```swift
class MacBookProduct: Product {
    func getPrice() -> Double {
        return 9999.00
    }
}

class VisionProduct: Product {
    func getPrice() -> Double {
        return 9999.00
    }
}
```

Decorator:

Maintains a reference to a Component object and defines an interface that conforms to Component's interface.

```swift
class BaseDecorator: Product {
    private var product: Product

    init(product: Product) {
        self.product = product
    }

    func getPrice() -> Double {
        return product.getPrice()
    }
}
```

ConcreteDecorator:

Adds responsibilities to the component.

```swift
class StorageDecorator: BaseDecorator {
    enum StorageOption: Double {
        case gb256 = 100.00
        case gb512 = 300.00
        case tb1 = 500.00
    }

    private let storageOption: StorageOption

    init(product: Product, storageOption: StorageOption) {
        self.storageOption = storageOption
        super.init(product: product)
    }

    override func getPrice() -> Double {
        return super.getPrice() + storageOption.rawValue
    }
}

class AppleCareDecorator: BaseDecorator {
    override func getPrice() -> Double {
        return super.getPrice() + 199.00
    }
}
```
