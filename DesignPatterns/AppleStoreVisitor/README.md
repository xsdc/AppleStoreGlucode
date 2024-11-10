![Visitor](https://github.com/user-attachments/assets/e860e3c8-0d4e-4a54-b2c9-ab5def845aea)

// RB: >>> If I was to score you on the quality of this content I would give you a 2 out of 10. 
<br />

# Visitor

> Represent an operation to be performed on the elements of an object structure. Visitor lets you define a new operation without changing the classes of the elements on which it operates.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

// RB: >>> what is an "object structure"? Why not just object?
// RB: >>> The example you give of adding damage doesn't capture the purpose of Visitor. Damage is probably a core feature of the game so you'd probably want to actually add that functionality directly to the game object. Adding a temporary discount to a Product is a better example. It's extending the functionality of a type with something that isn't core to the Type. 

- The Visitor pattern allows you to add new operations to existing object structures without modifying those structures.
- For example, for a shooter game, you can add a new operation to the game objects to calculate the damage they receive when hit by a bullet.
- This can be done without modifying the game objects themselves.

## Problem statement

// >>> RB: remove word "of" 
// >>> RB: "We would like a way to temporarily apply a discount to products in a catalog..."
- We would like a way of to update pricing for products in a catalog without increasing the complexity of the product classes.
- The visitor pattern allows us to do this by separating the calculation logic from the product classes.

## Domain application

Visitor:

- Declares a Visit operation for each class of ConcreteElement in the object structure.
- The operation's name and signature identifies the class that sends the Visit request to the visitor.
- That lets the visitor determine the concrete class of the element being visited.
- Then the visitor can access the element directly through its particular interface.

// RB: >>> If ProductVisitor defines a method `accept` how come its implementations don't conform to it?? It should be `func visit(product: Product)`

```swift
protocol ProductVisitor {
  func accept(visitor: ProductVisitor)
}
```

Concrete Visitor:

// RB >>> You talk about "fragment of the algorithms" and "traversal of the structure", but the examples don't map to any of this. I suggest removing this complexity completely as it isn't core to the concept of Visitor. 

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

// RB: >>> Use "method" instead of "operation": "defines an accept method"
// RB: >>> Protocol names should map to the functionality they require. `Product `is totally inappropriate here because a) it doesn't align with the protocols functionality, and b) you are totally conflating `Product` with `ProductVisitorAccepting`. Each one of your concrete visitors has a method `visit(product: Product)` and in those methods you call product.price. Can you see the problem? The type `Product` (as you have defined it) doesn't expose `price`!. This protocol should be named `ProductVisitorAccepting` to align with Swift API Guideline best practices, and each of your concrete products needs to conform to two protocols: `Product` and `ProductVisitorAccepting`. 

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
RB: >>> I personally don't think the below adds any value to explaining the concept of the Visitor Pattern. Up to you whether to leave it in or nor. 

ObjectStructure:

- Can enumerate its elements.
- May provide a high-level interface to allow the visitor to visit its elements.
- May either be a composite or a collection such as a list or a set.

```swift
class Catalog {
    private var products: [Product] = []

    func accept(visitor: ProductVisitor) {
        for product in products {
            product.accept(visitor: visitor)
        }
    }
}
```
