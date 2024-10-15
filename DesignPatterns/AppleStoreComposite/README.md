![5thAvenueNewYorkAppleStore](https://github.com/user-attachments/assets/386bae20-b662-470b-97a1-83b7ee367dfc)

<br />

# Composite

> Compose objects into tree structures to represent part-whole hierarchies. Composite lets clients treat individual objects and compositions of objects uniformly.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Overview

- Often, applications have a hierarchical tree structures where individual items (leaves) and groups of items (composites) coexist.
- For example, a file system includes files and directories, with directories able to contain both files and other directories.
- The Composite design pattern solves this issue by creating a shared interface, called the component interface, that allows clients to interact with both individual items and groups of items in a consistent manner.
- For instance, deleting a file or directory from a file system should be as simple as calling a single method, regardless of whether the item is a file or a directory.

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

Two examples are provided to illustrate the practical application of the Composite pattern, both applied to the Apple Store product catalog.

In these examples, the definitions are mapped to the domain as follows:

Component -> `CatalogItem`

Composite -> `CateglogCategory`

Leaf -> `CatalogProduct`

### Simple Example

- In the simple example, we unify the need for logging analytics events for categories and products.
- First, we define a protocol called `CatalogItem` (component), which will be shared between `CateglogCategory` and `CatalogProduct`.
- Then we include the `analyticsEvent` method, which returns a string representing the event to be logged.
- This approach allows for a unified way of logging events when users interact with items in the catalog, whether they are categories or products.

```swift
public protocol CatalogItem: Hashable {
    var id: String { get }
    var name: String { get }
    func analyticsEvent() -> String
}
```

- In the simple example, when selecting a category or product, the `analyticsEvent` method is called and the event is logged.
- The working SwiftUI is kept simple to illustrate this concept of the shared interface, ommiting the implementation of nested categories and products.

### Nested Example

- In the nested example, we provide any item within the hierachy a uniform way of displaying breadcrumb navigation.
- Given any product or category, we want to be able to retrieve the path of parent categories leading to it by calling a shared method.
- To achieve this, the `CatalogItem` protocol defines a method call `path` that returns an array of strings representing the path of categories leading to the item.
- To keep track of parent items efficiently, we also require a `parent` property that holds a reference to the parent category.
- By doing this, we are provided with a simple way to retrieve the hierarchy of categories leading to a specific product or category.

```swift
public protocol CatalogItem: Hashable {
    var parent: (any NestedExampleComposite.CatalogItem)? { get }
    var id: String { get }
    var name: String { get }
    func path() -> [String]
}
```
