![Visitor](https://github.com/user-attachments/assets/e860e3c8-0d4e-4a54-b2c9-ab5def845aea)

<br />

# Visitor

> Represent an operation to be performed on the elements of an object structure. Visitor lets you define a new operation without changing the classes of the elements on which it operates.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Visitor pattern enables adding functionality to existing objects without modifying them.
- A visitor is created separately, where the logic added.
- The visitor then accesses and operates on the existing objects.

## Illustrative example

- Consider an analytics service that tracks site traffic for each day of the year.
- We're presented with a log class that contains last years site traffic for each day in an array.
- We can implement a visitor to perform calculations using this array, separate from the log class.
- The visitor is given access to the log class, then we are able to calculate the average, total, or maximum traffic for the year.

## Problem statement

- We would like a way of calculating various product discount types without modifying `Product` objects.
- We'll use the Visitor pattern to perform the discount calculations separately from products.

## Domain application

#### Element:

- The class we would like to add external functionality to.
- Defines the `accept` method that takes a visitor.

```swift
protocol Product {
    func accept(visitor: DiscountVisitor)
}
```

#### Concrete elements:

Implements the `accept` method to accept a visitor.

```swift
struct MacBookProduct: Product {
    let id: String
    let price: Double

    func accept(visitor: DiscountVisitor) {
        visitor.visit(macBook: self)
    }
}

struct VisionProduct: Product {
    let id: String
    let price: Double

    func accept(visitor: DiscountVisitor) {
        visitor.visit(vision: self)
    }
}
```

#### Visitor:

Defines the discount calculation methods for each product type.

```swift
protocol DiscountVisitor {
    func visit(macBook: MacBookProduct)
    func visit(vision: VisionProduct)
}
```

#### Concrete visitors:

- Implements the discount calculations for each product type.
- Education discount is 25%.
- Employee discount is 50%.

```swift
class EducationDiscountVisitor: DiscountVisitor {
    private let discountPercentage = 0.25
    private var discount: Double = 0.0

    func getDiscount() -> Double {
        return discount
    }

    func visit(macBook: MacBookProduct) {
        discount = macBook.price * discountPercentage
    }

    func visit(vision: VisionProduct) {
        discount = vision.price * discountPercentage
    }
}

class EmployeeDiscountVisitor: DiscountVisitor {
    private let discountPercentage = 0.5
    private var discount: Double = 0.0

    func getDiscount() -> Double {
        return discount
    }

    func visit(macBook: MacBookProduct) {
        discount = macBook.price * discountPercentage
    }

    func visit(vision: VisionProduct) {
        discount = vision.price * discountPercentage
    }
}
```

## Usage

```swift
let educationDiscountVisitor = EducationDiscountVisitor()
let macBookProduct = MacBookProduct(id: "1", price: 1000.00)

macBookProduct.accept(visitor: educationDiscountVisitor)
print(educationDiscountVisitor.getDiscount()) // 250.00

let employeeDiscountVisitor = EmployeeDiscountVisitor()
let visionProduct = VisionProduct(id: "1", price: 10000.00)

visionProduct.accept(visitor: employeeDiscountVisitor)
print(employeeDiscountVisitor.getDiscount()) // 5000.00
```
