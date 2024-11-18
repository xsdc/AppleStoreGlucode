![Composite](https://github.com/user-attachments/assets/fd7e8458-74a1-4a9a-9fde-fd9ef404c1e9)

<br />

# Composite

> Compose objects into tree structures to represent part-whole hierarchies. Composite lets clients treat individual objects and compositions of objects uniformly.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Composite pattern allows us to build tree structures that treat individual objects and object groups uniformly.

- This can be compared to a file system, where a directory can contain files (individual objects) and other directories (object groups).

## Problem statement

- Let's assume the Apple Store has an app that allows employees to administer the catalog of products.

- The catalog contains categories, that may be nested, and products that belong to these categories.

- When an employee navigates the catalog, they should be able to view the breadcrumbs, whether they are looking at a category or a product.

- We can use the Composite pattern to add a requirement that each category and product should be able to display its own breadcrumbs.

## Definitions

- When an employee navigates the catalog, they should be able to view the breadcrumbs, whether they are looking at a category or a product.

- We can use the Composite pattern to add a requirement that each category and product should be able to display its own breadcrumbs.

- Applying the patterns helps us maintain a consistent interface for both categories and products.

- We are guaranteed that we can always call the `generateBreadcrumbs()` method on any object in the catalog.

## Definitions

#### Component:

The shared protocol for products and categories.

```swift
protocol CatalogItem: AnyObject {
    func generateBreadcrumbs() -> [String]
}
```

#### Composite:

- Composite nodes can contain leaf nodes and other composite nodes.

- Categories are the composite nodes in the catalog tree structure.

- They can contain other categories and products.

```swift
class CatalogCategory: CatalogItem {
    private let name: String

    init(name: String) {
        self.name = name
    }

    private var children: [any CatalogItem] = []
    private var parent: CatalogCategory?

    func addItem(_ item: any CatalogItem) {
        children.append(item)

        if let category = item as? CatalogCategory {
            category.parent = self
        }
        else if let product = item as? CatalogProduct {
            product.parent = self
        }
    }

    func generateBreadcrumbs() -> [String] {
        if let parent = parent {
            return parent.generateBreadcrumbs() + [name]
        }
        else {
            return [name]
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: CatalogCategory, rhs: CatalogCategory) -> Bool {
        return lhs.id == rhs.id
    }
}
```

#### Leaf:

- Leaf nodes do not have children.

- Products are the leaf nodes in the catalog tree structure.

```swift
class CatalogProduct: CatalogItem {
    private let name: String
    private let price: Double

    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }

    public var parent: CatalogCategory?

    func generateBreadcrumbs() -> [String] {
        if let parent = parent {
            return parent.generateBreadcrumbs() + [name]
        }
        else {
            return [name]
        }
    }
}
```

## Example

```swift
let catalog = CatalogCategory(name: "Catalog")
let macCategory = CatalogCategory(name: "Mac")
let macAccessoriesCategory = CatalogCategory(name: "Mac Accessories")
let macBookProCharger = CatalogProduct(name: "MacBook Pro Charger", price: 80)

catalog.addItem(macCategory)
macCategory.addItem(macAccessoriesCategory)
macAccessoriesCategory.addItem(macBookProCharger)

print(macBookProCharger.generateBreadcrumbs()) // ["Catalog", "Mac", "Mac Accessories", "MacBook Pro Charger"]
print(macAccessoriesCategory.generateBreadcrumbs()) // ["Catalog", "Mac", "Mac Accessories"]
print(macCategory.generateBreadcrumbs()) // ["Catalog", "Mac"]
```
