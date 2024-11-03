![5thAvenueNewYorkAppleStore](https://github.com/user-attachments/assets/386bae20-b662-470b-97a1-83b7ee367dfc)

<br />

# Composite

> Compose objects into tree structures to represent part-whole hierarchies. Composite lets clients treat individual objects and compositions of objects uniformly.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- Often, applications have a hierarchical tree structures where individual items (leaves) and groups of items (composites) coexist.
- For example, a file system includes files and directories, with directories able to contain both files and other directories.
- The Composite design pattern solves this issue by creating a shared interface, called the component interface, that allows clients to interact with both individual items and groups of items in a consistent manner.
- For instance, deleting a file or directory from a file system should be as simple as calling a single method, regardless of whether the item is a file or a directory.

## Problem statement

- We would like to build up a catalog of items, with products and categories.
- We want to be able to log analytics events when users interact with items in the catalog, whether they are products or categories.

## Domain application

Component:

- Declares the interface for objects in the composition.
- Implements default behavior for the interface common to all classes, as appropriate.
- Declares an interface for accessing and managing its child components.
- Defines an interface for accessing a component's parent in the recursive structure, and implements it if that's appropriate. (Optional)

```swift
protocol CatalogItem: Hashable {
    var id: String { get }
    var name: String { get }
    func analyticsEvent() -> String
}
```

Leaf:

- Represents leaf objects in the composition.
- A leaf has no children.
- Defines behavior for primitive objects in the composition.

```swift
class CatalogProduct: CatalogItem {
    let id: String
    let name: String
    let description: String
    let price: Double

    func analyticsEvent() -> String {
        return "catalog-product-" + id
    }
}
```

Composite:

- Defines behavior for components having children.
- Stores child components.
- Implements child-related operations in the Component interface.

```swift
class CatalogCategory: CatalogItem {
    let id: String
    let name: String
    var children: [any CatalogItem] = []

    func analyticsEvent() -> String {
        return "catalog-category-" + id
    }

    func addItem(_ item: any CatalogItem) {
        children.append(item)
    }

    func removeItem(_ item: any CatalogItem) {
        if let index = children.firstIndex(where: { $0.id == item.id }) {
            children.remove(at: index)
        }
    }
}
```

Client:

Manipulates objects in the composition through the Component interface.

```swift
class Catalog {
    var items: [any CatalogItem] = []

    func logAnalytics(for item: any CatalogItem) {
        // Use item.analyticsEvent()
    }
}
```
