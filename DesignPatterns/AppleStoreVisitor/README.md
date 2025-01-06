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

- Defines the protocol that accepts different types of discount visitors.

- Products are will be accepting visitors, so we define each roles involved in the Element.

```swift
public protocol Product {
    var id: String { get }
    var price: Double { get }
}

public protocol VisitorAccepting {
    func accept<V: Visitor>(_ visitor: V) -> V.VisitorResult
}
```

#### Concrete elements:

Concrete product types that accept a visitor according to the protocol defined above.

```swift
struct MacBookProProduct: Product, VisitorAccepting {
    let id: String
    let price: Double

    func accept<V: Visitor>(_ visitor: V) -> V.VisitorResult {
        visitor.visit(self)
    }
}

struct VisionProProduct: Product, VisitorAccepting {
    let id: String
    let price: Double

    func accept<V: Visitor>(_ visitor: V) -> V.VisitorResult {
        visitor.visit(self)
    }
}
```

#### Visitor:

- Defines the visitor protocol that will be implemented by concrete visitors.

- We are able to define the return type via the use of an associated type.

```swift
protocol Visitor {
    associatedtype VisitorResult
    func visit(_ product: Product) -> VisitorResult
}
```

#### Concrete visitors:

- Concrete visitors that implement the visitor protocol.

- We have three discount types: education and employee discounts, and a description visitor.

```swift
class EducationDiscountVisitor: Visitor {
    typealias VisitorResult = Double
    private let discountPercentage = 0.25

    func visit(_ product: Product) -> Double {
        product.price * discountPercentage
    }
}

class EmployeeDiscountVisitor: Visitor {
    typealias VistorResult = Double
    private let discountPercentage = 0.5

    func visit(_ product: Product) -> Double {
        product.price * discountPercentage
    }
}

class DescriptionVisitor: Visitor {
    typealias VisitorResult = String

    func visit(_ product: Product) -> String {
        "Product with ID \(product.id) costs $\(product.price)"
    }
}
```

## Example

```swift
// Education discount for MacBook Pro
let educationDiscountVisitor = EducationDiscountVisitor()
let macBookProProduct = MacBookProProduct(id: "1", price: 1000.00)
let macBookProEducationDiscount = macBookProProduct.accept(educationDiscountVisitor)
print(macBookProEducationDiscount) // 250.00

// Employee discount for Vision Pro
let employeeDiscountVisitor = EmployeeDiscountVisitor()
let visionProProduct = VisionProProduct(id: "2", price: 10000.00)
let visionProEmployeeDiscount = visionProProduct.accept(employeeDiscountVisitor)
print(visionProEmployeeDiscount) // 5000.00

// Description for MacBook Pro
let descriptionVisitor = DescriptionVisitor()
let macBookProDescription = macBookProProduct.accept(descriptionVisitor)
print(macBookProDescription) // Product with ID 1 costs $1000.0
```
