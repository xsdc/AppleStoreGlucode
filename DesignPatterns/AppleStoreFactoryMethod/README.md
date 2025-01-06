![FactoryMethod](https://github.com/user-attachments/assets/376c83ac-3602-4593-891a-3878419afa55)

<br />

# Factory Method

> Define an interface for creating an object, but let subclasses decide which class to instantiate. Factory Method lets a class defer instantiation to subclasses.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Factory Method pattern enables the creation of objects without specifying the exact class of the object that will be created.

- It allows the creation of different representations of an object based on the context.

- This allows for a robust and flexible design that can be easily extended.

## Problem statement

- The Apple Store provided multiple shipping options for customers to choose from.

- These include standard shipping, express shipping, international shipping, and in-store pickup.

- The shipping cost calculation and delivery date estimation are different for each shipping method.

- A problem we want to avoid is having a single class that handles all the shipping methods, which can lead to a large and complex class.

- The Factory Method pattern provides a solution by allowing separate classes for each shipping method that conform to a common protocol.

## Definitions

#### Product:

- Defines the protocol for the objects that the factory method creates.

- This provides a common interface for all `ShippingMethod` objects.

```swift
protocol ShippingMethod {
    var title: String { get }
    var deliveryDateEstimation: String { get }
    func shippingCost(forWeight: Double) -> Double
}
```
#### Concrete products:

- Implementations of the various shipping methods.

- The shipping cost and delivery estimation implementations are kept simple for demonstration purposes.

```swift
struct InStorePickupMethod: ShippingMethod {
    let title = "In-Store Pickup"

    var deliveryDateEstimation: String {
        return "Same day"
    }

    func shippingCost(forWeight weight: Double) -> Double {
        return 0
    }
}

struct StandardShippingMethod: ShippingMethod {
    let title = "Standard Shipping"

    var deliveryDateEstimation: String {
        return "3-5 business days"
    }

    func shippingCost(forWeight weight: Double) -> Double {
        return 0
    }
}

struct ExpressShippingMethod: ShippingMethod {
    let title = "Express Shipping"
    let baseShippingCost: Double

    var deliveryDateEstimation: String {
        return "1-2 business days"
    }

    func shippingCost(forWeight weight: Double) -> Double {
        return baseShippingCost * weight
    }
}

struct InternationalShippingMethod: ShippingMethod {
    let title = "International Shipping"
    let baseShippingCost: Double

    var deliveryDateEstimation: String {
        return "7-14 business days"
    }

    func shippingCost(forWeight weight: Double) -> Double {
        return baseShippingCost * weight
    }
}
```

#### Creator

- Declares the factory method, which returns an object of type `ShippingMethod`.

- Creators can also be defined as protocols for more complex scenarios where multiple creator classes are needed.

```swift
class ShippingMethodFactory {
    enum ShippingMethodType {
        case express, international, standard, inStorePickup
    }

    static func makeShippingMethod(_ method: ShippingMethodType) -> ShippingMethod {
        switch method {
        case .standard:
            return StandardShippingMethod()
        case .inStorePickup:
            return InStorePickupMethod()
        case .express:
            return ExpressShippingMethod(baseShippingCost: 5)
        case .international:
            return InternationalShippingMethod(baseShippingCost: 5)
        }
    }
}
```

## Example

```swift
let inStorePickupShippingMethod = ShippingMethodFactory.makeShippingMethod(.inStorePickup)
print(inStorePickupShippingMethod.title) // In-Store Pickup
print(inStorePickupShippingMethod.deliveryDateEstimation) // Same day
print(inStorePickupShippingMethod.shippingCost(forWeight: 5)) // 0.0

let standardShippingMethod = ShippingMethodFactory.makeShippingMethod(.standard)
print(standardShippingMethod.title) // Standard Shipping
print(standardShippingMethod.deliveryDateEstimation) // 3-5 business days
print(standardShippingMethod.shippingCost(forWeight: 5)) // 0.0

let expressShippingMethod = ShippingMethodFactory.makeShippingMethod(.express)
print(expressShippingMethod.title) // Express Shipping
print(expressShippingMethod.deliveryDateEstimation) // 1-2 business days
print(expressShippingMethod.shippingCost(forWeight: 5)) // 25.0

let internationalShippingMethod = ShippingMethodFactory.makeShippingMethod(.international)
print(internationalShippingMethod.title) // International Shipping
print(internationalShippingMethod.deliveryDateEstimation) // 7-14 business days
print(internationalShippingMethod.shippingCost(forWeight: 10)) // 50.0
```
