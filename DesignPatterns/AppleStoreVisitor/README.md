<br />

# Visitor

> Represent an operation to be performed on the elements of an object structure. Visitor lets you define a new operation without changing the classes of the elements on which it operates.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Visitor pattern allows you to add new operations to existing object structures without modifying those structures.
- For example, for a shooter game, you can add a new operation to the game objects to calculate the damage they receive when hit by a bullet.
- This can be done without modifying the game objects themselves.

## Problem statement

- We would like a way of to update pricing for products in a catalog without increasing the complexity of the product classes.
- The visitor pattern allows us to do this by separating the calculation logic from the product classes.

## Domain application

Visitor:

- Declares a Visit operation for each class of ConcreteElement in the object structure.
- The operation's name and signature identifies the class that sends the Visit request to the visitor.
- That lets the visitor determine the concrete class of the element being visited.
- Then the visitor can access the element directly through its particular interface.

```swift
protocol ProductVisitor {
  func accept(visitor: ProductVisitor)
}
```

Concrete Visitor:

- Implements each operation declared by Visitor.
- Each operation implements a fragment of the algorithm defined for the corresponding class of object in the structure.
- ConcreteVisitor provides the context for the algorithm and stores its local state.
- This state often accumulates results during the traversal of the structure.

```swift
class EducationDiscountVisitor: ProductVisitor {
    private let discountPercentage = 0.25

    func visit(product: Product) {
        product.price -= product.price * discountPercentage
    }
}

class EmployeeDiscountVisitor: ProductVisitor {
    private let discountPercentage = 0.5

    func visit(product: Product) {
        product.price -= product.price * discountPercentage
    }
}
```

Element:

Defines an Accept operation that takes a visitor as an argument.

```swift
protocol Product {
    func accept(visitor: inout ProductVisitor)
}
```

ConcreteElement:

Implements an Accept operation that takes a visitor as an argument.

```swift
struct MacBookProduct: Product {
    let id: String
    let price: Double

    func accept(visitor: ProductVisitor) {
        visitor.visit(macProduct: self)
    }
}

struct VisionProduct: Product {
    let id: String
    let price: Double

    func accept(visitor: ProductVisitor) {
        visitor.visit(visionProduct: self)
    }
}
```

ObjectStructure:

- Can enumerate its elements.
- May provide a high-level interface to allow the visitor to visit its elements.
- May either be a composite or a collection such as a list or a set.

```swift
class Catalog {
    private var products: [Product] = []

    func addProduct(_ product: Product) {
        products.append(product)
    }

    func accept(visitor: ProductVisitor) {
        for product in products {
            product.acceptVisitor(visitor: &visitor)
        }
    }
}
```
