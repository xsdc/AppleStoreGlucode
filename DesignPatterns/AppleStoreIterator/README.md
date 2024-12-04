![Iterator](https://github.com/user-attachments/assets/12912e28-c814-4aed-b065-4409ac7ce7b5)

<br />

# Iterator

> Provide a way to access the elements of an aggregate object sequentially without exposing its underlying representation.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Iterator pattern provides a way to access elements of a sequence without exposing the underlying representation.

- The underlying representation could be any collection type.

- These include sets, arrays, dictionaries, linked lists, etc.

-  The traversel of the collection is encapsulated, and a uniform interface is provided to access the elements.

## Problem statement

- Let's imagine the Apple Store is administered via an internal app.

- In this app, we have a master view that displays categories, and a detail view that displays the products for a selected category.

- We are able to drag and drop the products into different categories, in case they are incorrectly assigned.

- The app is still under development, and at this point the underlying data structure for the catalog is a dictionary.

- We want to avoid problem of coupling our code to the dictionary when traversing the categories and products.

- The Iterator pattern enables traversing the dictionary without exposing the underlying representation.

- By providing a uniform interface to access the elements, we can easily switch the underlying data structure in the future.

- In the example below, we will implement the Iterator pattern to traverse the categories in the Apple Store catalog. We'll omii the product details for simplicity.

## Definitions

#### Iterator:

Defines the operation to traverse elements.


```swift
protocol CatalogIterator {
    func next() -> Category?
}
```

#### Concrete iterators:

- Implements the `CatalogIterator` to traverse the collection.

- The implementation is specific to the underlying data structure.

```swift
class ArrayCatalogIterator: CatalogIterator {
    private let categories: [String]
    private var index = 0

    init(categories: [String]) {
        self.categories = categories
    }

    func next() -> Category? {
        guard index < categories.count else { return nil }
        let category = Category(name: categories[index])
        index += 1
        return category
    }
}

class DictionaryCatalogIterator: CatalogIterator {
    private let categories: [String]
    private var index = 0

    init(categories: [String: String]) {
        self.categories = categories
            .sorted { $0.key < $1.key }
            .map { $0.value }
    }

    func next() -> Category? {
        guard index < categories.count else { return nil }
        let category = Category(name: categories[index])
        index += 1
        return category
    }
}
```

#### Aggregate:

Defines an interface for creating an Iterator object.

```swift
protocol CatalogCollection {
    func makeIterator() -> CatalogIterator
}
```

#### Concrete aggregates:

- Implements the `CatalogCollection` protocol to create an iterator.

- By using the iterator, we can access the elements of the collection.

```swift
struct ArrayCatalog: CatalogCollection {
    private let categories: [String]

    init(categories: [String]) {
        self.categories = categories
    }

    func makeIterator() -> CatalogIterator {
        return ArrayCatalogIterator(categories: categories)
    }
}

class DictionaryCatalog: CatalogCollection {
    private let categories: [String: String]

    init(categories: [String: String]) {
        self.categories = categories
    }

    func makeIterator() -> CatalogIterator {
        return DictionaryCatalogIterator(categories: categories)
    }
}
```

## Example: Array

```swift
struct Category {
    let name: String
}

let categories = ["iPhone", "iPad", "Mac", "Watch"]
let arrayCatalog = ArrayCatalog(categories: categories)
let arrayIterator = arrayCatalog.makeIterator()

while let category = arrayIterator.next() {
    print(category.name)
}
// Output:
// iPhone
// iPad
// Mac
// Watch
```

## Example: Dictionary

```swift
let categoryDictionary = [
    "1": "iPhone",
    "2": "iPad",
    "3": "Mac",
    "4": "Watch"
]
let dictionaryCatalog = DictionaryCatalog(categories: categoryDictionary)
let dictionaryIterator = dictionaryCatalog.makeIterator()

while let category = dictionaryIterator.next() {
    print(category.name)
}
// Output:
// iPhone
// iPad
// Mac
// Watch
```
