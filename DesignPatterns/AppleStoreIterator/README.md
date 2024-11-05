![Iterator](https://github.com/user-attachments/assets/45647a91-4b71-4637-b430-30ead8e28ec8)

<br />

# Iterator

> Provide a way to access the elements of an aggregate object sequentially without exposing its underlying representation.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Iterator pattern provides a way to access the elements of an aggregate object sequentially without exposing its underlying representation.
- The pattern has two main components: the Iterator and the Aggregate.
- The Iterator defines an interface for accessing and traversing elements, while the Aggregate defines an interface for creating an Iterator object.

## Problem statement

- We would like to provide a way to traverse products in a category, to provide a way to access the elements of an aggregate object sequentially without exposing its underlying representation.
- This allows flexibility to change the internal representation of the collection without changing the code that uses the collection.

## Domain application

Iterator:

Defines an interface for accessing and traversing elements.

```swift
protocol Iterator {
    func first()
    func next()
    func isDone() -> Bool
    func currentItem() -> Any
}
```

Concretelterator:

- Implements the Iterator interface.
- Keeps track of the current position in the traversal of the aggregate.

```swift
class Product: Iterator {
    private var products: [String]
    private var current: Int = 0

    init(products: [String]) {
        self.products = products
    }

    func first() {
        current = 0
    }

    func next() {
        current += 1
    }

    func isDone() -> Bool {
        return current >= products.count
    }

    func currentItem() -> Any {
        return products[current]
    }
}
```

Aggregate:

Defines an interface for creating an Iterator object.

```swift
protocol Aggregate {
    func createIterator() -> Iterator
}
```

ConcreteAggregate:

Implements the Iterator creation interface to return an instance of the proper Concretelterator.

```swift
class Category: Aggregate {
    private var products: [String] = []

    func addProduct(product: String) {
        products.append(product)
    }

    func createIterator() -> Iterator {
        return Product(products: products)
    }
}
```
