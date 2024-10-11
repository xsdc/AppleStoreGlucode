![Composite](https://github.com/user-attachments/assets/dfbd0dbd-1ab2-47b1-8fcf-6d5cb7307234)

<br />

# Composite

> Compose objects into tree structures to represent part-whole hierarchies. Composite lets clients treat individual objects and compositions of objects uniformly.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Overview

The composite design pattern addresses the challenge of treating objects in a tree structure uniformly. By defining a shared interface, known as the component interface, it allows clients to interact with both individual objects (leaves) and groups of objects (composites) in a consistent manner.
This pattern is particularly useful when you need to perform operations on all objects within a tree structure, regardless of whether they are leaves or composites.

## Definitions

#### Component: A protocol that represents all objects in the hierarchy

```swift
protocol Component {
    var id: String { get }
    var name: String { get }
}
```

#### Composite: A component that can hold other components

```swift
struct Composite: Component {
    let id: String
    let name: String
    var children: [Component] = []

    mutating func addComponent(_ component: Component) {
        children.append(component)
    }

    mutating func removeComponent(_ component: Component) {
        if let index = children.firstIndex(where: { $0.id == component.id }) {
            children.remove(at: index)
        }
    }
}
```

#### Leaf: A component that has no children

```swift
struct Leaf: Component {
    let id: String
    let name: String
    let description: String
}
```

## Apple Store application

Two examples are provided illustrating the practical application of the composite pattern, both applied to the Apple Store product catalog.

In our examples, the definitions are mapped to the domain as follows:

Component -> `CatalogItem`

Composite -> `CateglogCategory`

Leaf -> `CatalogProduct`

### Simple Example

In the first example, we define a protocol for catalog items that includes an analytics event identifier.

```swift
public protocol CatalogItem: Hashable {
    var id: String { get }
    var name: String { get }
    func analyticsEvent() -> String
}
```

This approach allows for simple event logging when users interact with items in the catalog.

### Nested Example

In the second example, we expand the CatalogItem protocol to include a method that retrieves the path of parent categories, enabling breadcrumb navigation.

```swift
public protocol CatalogItem: Hashable {
    var parent: (any NestedExampleComposite.CatalogItem)? { get }
    var id: String { get }
    var name: String { get }
    func path() -> [String]
}
```

This method provides a clear way to understand the hierarchy of categories leading to a specific product.
