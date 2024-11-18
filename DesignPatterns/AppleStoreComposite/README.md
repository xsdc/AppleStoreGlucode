![5thAvenueNewYorkAppleStore](https://github.com/user-attachments/assets/386bae20-b662-470b-97a1-83b7ee367dfc)

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

#### Component:

The shared protocol for products and categories.

```swift
protocol CatalogItem: AnyObject, Hashable {
    var id: String { get }
    var name: String { get }
    func generateBreadcrumbs() -> [String]
}
```

#### Composite:

- Composite nodes can contain leaf nodes and other composite nodes.

- Categories are the composite nodes in the tree structure.

- They can contain other categories and products.

```swift
class CatalogCategory: CatalogItem {
    let id: String
    let name: String
    private(set) var children: [any CatalogItem] = []
    weak var parent: CatalogCategory?

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }

    func addItem(_ item: any CatalogItem) {
        children.append(item)
        if let category = item as? CatalogCategory {
            category.parent = self
        } else if let product = item as? CatalogProduct {
            product.parent = self
        }
    }

    func generateBreadcrumbs() -> [String] {
        if let parent = parent {
            return parent.generateBreadcrumbs() + [name]
        } else {
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

- Products are the leaf nodes in the tree structure.

```swift
class CatalogProduct: CatalogItem {
    let id: String
    let name: String
    private let description: String
    private let price: Double
    weak var parent: CatalogCategory?

    init(id: String, name: String, description: String, price: Double) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
    }

    func generateBreadcrumbs() -> [String] {
        if let parent = parent {
            return parent.generateBreadcrumbs() + [name]
        } else {
            return [name]
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: CatalogProduct, rhs: CatalogProduct) -> Bool {
        return lhs.id == rhs.id
    }
}
```

## Example

```swift
let catalog = CatalogCategory(id: "1", name: "Catalog")
let macCategory = CatalogCategory(id: "3", name: "Mac")
let macAccessoriesCategory = CatalogCategory(id: "4", name: "Mac Accessories")
let macBookProCharger = CatalogProduct(id: "7", name: "MacBook Pro Charger", description: "A charger for the MacBook Pro", price: 80)

catalog.addItem(macCategory)
macCategory.addItem(macAccessoriesCategory)
macAccessoriesCategory.addItem(macBookProCharger)

print(macBookProCharger.generateBreadcrumbs()) // ["Catalog", "Mac", "Mac Accessories", "MacBook Pro Charger"]
print(macAccessoriesCategory.generateBreadcrumbs()) // ["Catalog", "Mac", "Mac Accessories"]
print(macCategory.generateBreadcrumbs()) // ["Catalog", "Mac"]
```
