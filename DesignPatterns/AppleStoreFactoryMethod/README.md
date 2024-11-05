<br />

# Factory Method

> Define an interface for creating an object, but let subclasses decide which class to instantiate. Factory Method lets a class defer instantiation to subclasses.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Factory Method pattern defines an interface for creating an object, but lets subclasses decide which class to instantiate.
- For example, for a plane factory, the factory method would create a plane object, but the subclass would decide whether to create a fighter plane or a passenger plane.
- The Factory Method pattern is useful when a class can't anticipate the class of objects it must create.

## Problem statement

- For the Apple Store, the factory method pattern can be used to create different types of products, such as iPhones, iPads, and MacBooks.
- The factory method would create a product object, but the subclass would decide whether to create an iPhone, iPad, or MacBook.

## Domain application

Product:

Defines the interface of objects the factory method creates.

```swift
protocol Product {
    func description()
}
```
ConcreteProduct:

Implements the Product interface.

```swift
class MacBookProduct: Product {
    func description() {
        // MacBook Pro
    }
}

class VisionProduct: Product {
    func description() {
        // Vision Pro
    }
}
```

Creator:

- Declares the factory method, which returns an object of type Product. Creator may also define a default implementation of the factory method that returns a default ConcreteProduct object.
- May call the factory method to create a Product object.

```swift
protocol CatalogFactory {
    func factoryMethod() -> Product
}
```

ConcreteCreator:

Overrides the factory method to return an instance of a ConcreteProduct.

```swift
class MacBookFactory: CatalogFactory {
    override func factoryMethod() -> Product {
        return MacBookProduct()
    }
}
```
