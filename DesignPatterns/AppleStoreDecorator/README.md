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
    var price: Decimal { get }
}
```

#### Concrete components:

Defines the base products.

```swift
struct MacBookProProduct: PriceProviding {
    let price: Decimal = 5_000
}

struct VisionProProduct: PriceProviding {
    let price: Decimal = 3_500
}
```

#### Decorator:

- Provides wrapper types that conform to `PriceProviding`.

- They always contain a decorated subject that can have options added to it.

```swift
struct StoragePrice: PriceProviding {
    private let decoratedSubject: any PriceProviding
    private let storagePrice: Decimal
    init(decoratedSubject: any PriceProviding, storagePrice: Decimal) {
        self.decoratedSubject = decoratedSubject
        self.storagePrice = storagePrice
    }

    var price: Decimal { decoratedSubject.price + storagePrice }
}
```

#### Concrete decorator:

- The concrete decorators add new options to the base product.

- They compute `price` by adding their own cost to the decorated subject.

```swift
struct AppleCare: PriceProviding {
    private let decoratedSubject: any PriceProviding
    private static let addOnPrice: Decimal = 200

    init(decoratedSubject: any PriceProviding) {
        self.decoratedSubject = decoratedSubject
    }

    var price: Decimal { decoratedSubject.price + Self.addOnPrice }
}
```

## Example

```swift
let macBookPro = MacBookProProduct()
let macBookProWithStorage = StoragePrice(decoratedSubject: macBookPro, storagePrice: 500)
let macBookProWithStorageAndAppleCare = AppleCare(decoratedSubject: macBookProWithStorage)

print(macBookPro.price) // 5000
print(macBookProWithStorage.price) // 5500
print(macBookProWithStorageAndAppleCare.price) // 5700

let visionPro = VisionProProduct()
let visionProWithStorage = StoragePrice(decoratedSubject: visionPro, storagePrice: 300)
let visionProWithStorageAndAppleCare = AppleCare(decoratedSubject: visionProWithStorage)

print(visionPro.price) // 3500
print(visionProWithStorage.price) // 3800
print(visionProWithStorageAndAppleCare.price) // 4000
```
