![Decorator](https://github.com/user-attachments/assets/79606909-0f77-4fde-af76-6dd43c31ea1c)

<br />

# Decorator

> Attach additional responsibilities to an object dynamically. Decorators provide a flexible alternative to subclassing for extending functionality.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Decorator pattern allows adding new behaviors to objects dynamically by placing them inside special wrapper objects that contain these behaviors.

- These behaviors can be stacked on top of each other, allowing for a flexible way to add new features to objects.

## Problem statement

- When configuring a product, there are often multiple options to choose with different prices.

- There are also fixed price options that can be added to the product, such as AppleCare.

- The problem we are faced with is how to calculate the final price of a product based on the selected options.

- We would like to solve this problem in a way where each option conforms to the single responsibility principle and can be added dynamically.

- The Decorator pattern helps us achieve this by enabling the chaining of multiple options together to calculate the final price of a product.

## Definitions

#### Component:

Defines the protocol for objects that can have responsibilities added to them dynamically.

```swift
protocol PriceProviding {
    var price: Double { get }
}
```

#### Concrete components:

Defines the base products.

```swift
class MacBookProProduct: PriceProviding {
    var price: Double {
        return 5000.00
    }
}

class VisionProProduct: PriceProviding {
    var price: Double {
        return 3500.00
    }
}
```

#### Decorator:

- Provides the base class for all decorators.

- They alway contain a base product, that can then have options added to it.

```swift
class PriceDecorator: PriceProviding {
    private let product: PriceProviding

    init(product: PriceProviding) {
        self.product = product
    }

    var price: Double {
        return product.price
    }
}
```

#### Concrete decorator:

- The concrete decorators add new options to the base product.

- They override the `price` computed property to add the cost of the new option to the base product.

```swift
class StoragePriceDecorator: PriceDecorator {
    enum StorageOption: Double {
        case gb256 = 100.00
        case gb512 = 300.00
        case tb1 = 500.00
    }

    private let storageOption: StorageOption

    init(product: PriceProviding, storageOption: StorageOption) {
        self.storageOption = storageOption
        super.init(product: product)
    }

    override var price: Double {
        return super.price + storageOption.rawValue
    }
}

class AppleCarePriceDecorator: PriceDecorator {
    override var price: Double {
        return super.price + 200.00
    }
}
```

## Example

```swift
let macBookPro = MacBookProProduct()
let macBookProWithStorage = StoragePriceDecorator(product: macBookPro, storageOption: .tb1)
let macBookProWithStorageAndAppleCare = AppleCarePriceDecorator(product: macBookProWithStorage)

print(macBookPro.price) // 5000.0
print(macBookProWithStorage.price) // 5500.0
print(macBookProWithStorageAndAppleCare.price) // 5700.0

let visionPro = VisionProProduct()
let visionProWithStorage = StoragePriceDecorator(product: visionPro, storageOption: .gb512)
let visionProWithStorageAndAppleCare = AppleCarePriceDecorator(product: visionProWithStorage)

print(visionPro.price) // 3500.0
print(visionProWithStorage.price) // 3800.0
print(visionProWithStorageAndAppleCare.price) // 4000.0
```
