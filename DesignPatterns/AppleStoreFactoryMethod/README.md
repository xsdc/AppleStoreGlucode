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
    let title: String = "In-Store Pickup"

    var deliveryDateEstimation: String {
        return "Same day"
    }

    func shippingCost(forWeight weight: Double) -> Double {
        return 0
    }
}

struct StandardShippingMethod: ShippingMethod {
    let title: String = "Standard Shipping"

    var deliveryDateEstimation: String {
        return "3-5 business days"
    }

    func shippingCost(forWeight weight: Double) -> Double {
        return 0
    }
}

struct ExpressShippingMethod: ShippingMethod {
    let title: String = "Express Shipping"
    let baseShippingCost: Double

    var deliveryDateEstimation: String {
        return "1-2 business days"
    }

    func shippingCost(forWeight weight: Double) -> Double {
        return baseShippingCost * weight
    }
}

struct InternationalShippingMethod: ShippingMethod {
    let title: String = "International Shipping"
    let baseShippingCost: Double

    var deliveryDateEstimation: String {
        return "7-14 business days"
    }

    func shippingCost(forWeight weight: Double) -> Double {
        return baseShippingCost * weight
    }
}
```

#### Creator:

- The protocol that is to be used to create shipping methods and return them as `ShippingMethod` objects.

- This abstraction enables creating objects without specifying the exact class of the object that will be created.

```swift
protocol ShippingMethodCreating {
    static func makeShippingMethod(withBaseShippingCost cost: Double) -> ShippingMethod
}
```

#### Concrete creators:

- Implementations of the `ShippingMethodCreating` protocol that create specific shipping methods.

- The base shipping cost and weight are used to calculate the shipping cost.

- This illustrates how the Factory Method pattern can be used to create different representations of an object based on the context.

```swift
struct InStorePickupShippingMethodFactory: ShippingMethodCreating {
    static func makeShippingMethod(withBaseShippingCost cost: Double = 0) -> ShippingMethod {
        return InStorePickupMethod()
    }
}

struct StandardShippingMethodFactory: ShippingMethodCreating {
    static func makeShippingMethod(withBaseShippingCost cost: Double = 0) -> ShippingMethod {
        return StandardShippingMethod()
    }
}

struct ExpressShippingMethodFactory: ShippingMethodCreating {
    static func makeShippingMethod(withBaseShippingCost cost: Double) -> ShippingMethod {
        return ExpressShippingMethod(baseShippingCost: cost)
    }
}

struct InternationalShippingMethodFactory: ShippingMethodCreating {
    static func makeShippingMethod(withBaseShippingCost cost: Double) -> ShippingMethod {
        return InternationalShippingMethod(baseShippingCost: cost)
    }
}
```

## Example

```swift
let inStorePickupShippingMethod = InStorePickupShippingMethodFactory.makeShippingMethod()
print(inStorePickupShippingMethod.title) // In-Store Pickup
print(inStorePickupShippingMethod.deliveryDateEstimation) // Same day
print(inStorePickupShippingMethod.shippingCost(forWeight: 5)) // 0.0

let standardShippingMethod = StandardShippingMethodFactory.makeShippingMethod()
print(standardShippingMethod.title) // Standard Shipping
print(standardShippingMethod.deliveryDateEstimation) // 3-5 business days
print(standardShippingMethod.shippingCost(forWeight: 5)) // 0.0

let expressShippingMethod = ExpressShippingMethodFactory.makeShippingMethod(withBaseShippingCost: 5)
print(expressShippingMethod.title) // Express Shipping
print(expressShippingMethod.deliveryDateEstimation) // 1-2 business days
print(expressShippingMethod.shippingCost(forWeight: 5)) // 25.0

let internationalShippingMethod = InternationalShippingMethodFactory.makeShippingMethod(withBaseShippingCost: 10)
print(internationalShippingMethod.title) // International Shipping
print(internationalShippingMethod.deliveryDateEstimation) // 7-14 business days
print(internationalShippingMethod.shippingCost(forWeight: 5)) // 50.0
```
