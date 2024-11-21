![Visitor](https://github.com/user-attachments/assets/e860e3c8-0d4e-4a54-b2c9-ab5def845aea)

<br />

# Visitor

> Represent an operation to be performed on the elements of an object structure. Visitor lets you define a new operation without changing the classes of the elements on which it operates.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Visitor pattern provides a way of adding functionality to existing objects without modifying them.

- A visitor is created separately from the existing objects it operates on.

- The visitor accesses an existing object, and performs the additional functionality.

## Problem statement

- Assume we need to calculate discounts on various Apple Store products.

- The discounts have various types, such as education and employee discounts.

- Discount percentages can vary at any point, and additional discount types may be added in the future.

- We would like to avoid the problem of modifying the product objects directly every time a new discount type is added, or the discount percentage changes.

- The visitor pattern will allow us to separate discount types, and vary their discount percentages, without modifying the product classes, satifying the open/closed principle.

## Definitions

#### Element:

The protocol that accepts a visitor for the objects we would like to add functionality to.

```swift
protocol DiscountVisitorAccepting {
    func accept(_ visitor: DiscountVisitor)
}
```

#### Concrete elements:

Concrete product types that accept a visitor according to the protocol defined above.

```swift
struct MacBookProProduct: DiscountVisitorAccepting {
    let id: String
    let price: Double

    func accept(_ visitor: DiscountVisitor) {
        visitor.acceptAndVisit(self)
    }
}

struct VisionProProduct: DiscountVisitorAccepting {
    let id: String
    let price: Double

    func accept(_ visitor: DiscountVisitor) {
        visitor.acceptAndVisit(self)
    }
}
```

#### Visitor:

Defines the discount calculation methods for each product type.

```swift
protocol DiscountVisitor {
    func acceptAndVisit(_ macBookPro: MacBookProProduct)
    func acceptAndVisit(_ visionPro: VisionProProduct)
}
```

#### Concrete visitors:

- Implements the discount calculations for each product type.

- Education discount is 25%.

- Employee discount is 50%.

```swift
class EducationDiscountVisitor: DiscountVisitor {
    private let discountPercentage = 0.25
    private(set) var macBookProDiscount: Double = 0.0
    private(set) var visionProDiscount: Double = 0.0

    func acceptAndVisit(_ macBookPro: MacBookProProduct) {
        macBookProDiscount = macBookPro.price * discountPercentage
    }

    func acceptAndVisit(_ visionPro: VisionProProduct) {
        visionProDiscount = visionPro.price * discountPercentage
    }
}

class EmployeeDiscountVisitor: DiscountVisitor {
    private let discountPercentage = 0.5
    private(set) var macBookProDiscount: Double = 0.0
    private(set) var visionProDiscount: Double = 0.0

    func acceptAndVisit(_ macBookPro: MacBookProProduct) {
        macBookProDiscount = macBookPro.price * discountPercentage
    }

    func acceptAndVisit(_ visionPro: VisionProProduct) {
        visionProDiscount = visionPro.price * discountPercentage
    }
}
```

## Example

```swift
// Education discount for MacBook Pro

let educationDiscountVisitor = EducationDiscountVisitor()

let macBookProProduct = MacBookProProduct(id: "1", price: 1000.00)
macBookProProduct.accept(educationDiscountVisitor)

print(educationDiscountVisitor.macBookProDiscount) // 250.00

// Employee discount for Vision Pro

let employeeDiscountVisitor = EmployeeDiscountVisitor()

let visionProProduct = VisionProProduct(id: "1", price: 10000.00)
visionProProduct.accept(employeeDiscountVisitor)

print(employeeDiscountVisitor.visionProDiscount) // 5000.00
```
