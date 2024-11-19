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

- Let's assume the Apple Store has an app that allows employees to manage the catalog of products.

- The catalog contains categories, that may be nested, and products that belong to categories.

- When an employee navigates the catalog, they should be able to view the breadcrumbs, whether they are looking at a category or a product.

- Inheritantly, the problem arises where we don't have a consistent way to retrieve the breadcrumbs for categories and products.

- Ideally, we would like to be able to retrieve the breadcrumbs for any category or product using the same computed property `breadcrumbs`.

- The Composite pattern helps us solve this problem by allowing us to treat categories and products uniformly.

## Definitions

#### Component:

The shared protocol for products and categories.

```swift
protocol BreadcrumbProviding {
    var breadcrumbs: [String] { get }
}
```

#### Composite:

- Composite nodes can contain leaf nodes and other composite nodes.

- Categories are the composite nodes in the catalog tree structure.

- They can contain other categories and products.

```swift
class Category: BreadcrumbProviding {
    let name: String
    private var children: [BreadcrumbProviding] = []
    private var parent: Category?

    init(name: String, parent: Category?) {
        self.name = name
        self.parent = parent
    }

    func addChild(_ child: BreadcrumbProviding) {
        if let category = child as? Category {
            children.append(category)
        }

        if let product = child as? Product {
            product.setParent(self)
            children.append(product)
        }
    }

    var breadcrumbs: [String] {
        if let parent = parent {
            return parent.breadcrumbs + [name]
        }
        else {
            return [name]
        }
    }
}
```

#### Leaf:

- Leaf nodes do not have children.

- Products are the leaf nodes in the catalog tree structure.

```swift
class Product: BreadcrumbProviding {
    let name: String
    let price: Double
    private var parent: Category?

    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }

    var breadcrumbs: [String] {
        if let parent = parent {
            return parent.breadcrumbs + [name]
        }
        else {
            return [name]
        }
    }

    func setParent(_ parent: Category) {
        self.parent = parent
    }
}
```

## Example

```swift
let rootCategory = Category(name: "Catalog", parent: nil)
let macCategory = Category(name: "Mac", parent: rootCategory)
let macBookCategory = Category(name: "MacBook", parent: macCategory)

let macBookPro = Product(name: "MacBook Pro", price: 1299.99)
let macBookAir = Product(name: "MacBook Air", price: 999.99)

macBookCategory.addChild(macBookPro)
macBookCategory.addChild(macBookAir)

print(rootCategory.breadcrumbs) // ["Catalog"]
print(macCategory.breadcrumbs) // ["Catalog", "Mac"]
print(macBookCategory.breadcrumbs) // ["Catalog", "Mac", "MacBook"]
print(macBookPro.breadcrumbs) // ["Catalog", "Mac", "MacBook", "MacBook Pro"]
print(macBookAir.breadcrumbs) // ["Catalog", "Mac", "MacBook", "MacBook Air"]
```
