![Memento](https://github.com/user-attachments/assets/2c913554-ed5b-4df2-99e7-20b83e1f01b8)

<br />

# Memento

> Without violating encapsulation, capture and externalize an object's internal state so that the object can be restored to this state later.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Memento pattern is used to store the state of an object.

- These can be stored in a stack, which allows for undo and redo operations.

- The pattern focuses on encapsulation by ensuring that saved states are not able to be manipulated.

## Problem statement

- At the moment, the Apple Store allows users to remove products from their bag, then the option to undo the removal is provided.

- Only one undo operation is supported though.

- We are tasked with implementing an undo system for multiple removed products.

- The problem may arise that the saved states could be manipulated if they are exposed.

- The Memento pattern allows us to manage the product removal stack without exposing the internal state of the bag.

- This way, we can implement the undo system without violating encapsulation, and retain the integrity of the saved states.

## Definitions

#### Originator:

- The object whose state needs to be saved.

- Creates a memento containing a snapshot of its current internal state.

- Uses the memento to restore its internal state as needed.

```swift
class Bag {
    private(set) var products: [Product]

    init(products: [Product] = []) {
        self.products = products
    }

    func save() -> BagState {
        BagState(products: products)
    }

    func restore(from state: BagState) {
        products = state.products
    }

    func removeProduct(withID id: String) {
        products.removeAll { $0.id == id }
    }
}
```

#### Memento:

- Provides the structure needed to store the state of the bag.

- We only need to store the products in the bag, so other details are omitted.

- Other properties can be added as needed, such as the bag's total price.

```swift
struct BagState {
    let products: [Product]
}
```

#### Caretaker:

- Is responsible for the memento management.

- Never operates on or examines the contents of a memento.

- Redo and undo systems can be implemented in various ways.

- Here we are only required to implement the undo system for a stack of removed products.

```swift
class BagManager {
    private var bag: Bag
    private var undoStates: [BagState] = []

    init(bag: Bag = Bag()) {
        self.bag = bag
    }

    var isAbleToUndo: Bool {
        !undoStates.isEmpty
    }

    func undo() {
        guard let lastUndoState = undoStates.popLast() else { return }
        bag.restore(from: lastUndoState)
    }

    func removeProduct(withID id: String) {
        undoStates.append(bag.save())
        bag.removeProduct(withID: id)
    }
}
```

## Example

```swift
struct Product: Equatable {
    let id: String
    let name: String
}

let bagProducts = [
    Product(id: "A", name: "iPhone 16 Pro"),
    Product(id: "B", name: "AirPods Pro")
]
let bag = Bag(products: bagProducts)
let bagManager = BagManager(bag: bag)

print(bag.products) // [Product(id: "A", name: "iPhone 16 Pro"), Product(id: "B", name: "AirPods Pro")]
print(bagManager.isAbleToUndo) // false

bagManager.removeProduct(withID: "A")

print(bag.products) // [Product(id: "B", name: "AirPods Pro")]
print(bagManager.isAbleToUndo) // true

bagManager.removeProduct(withID: "B")

print(bag.products) // []
print(bagManager.isAbleToUndo) // true

bagManager.undo()

print(bag.products) // [Product(id: "B", name: "AirPods Pro")]
print(bagManager.isAbleToUndo) // true

bagManager.undo()

print(bag.products) // [Product(id: "A", name: "iPhone 16 Pro"), Product(id: "B", name: "AirPods Pro")]
print(bagManager.isAbleToUndo) // false
```
