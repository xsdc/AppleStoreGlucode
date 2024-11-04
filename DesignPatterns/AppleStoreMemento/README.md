![Memento](https://github.com/user-attachments/assets/2c913554-ed5b-4df2-99e7-20b83e1f01b8)

<br />

# Memento

> Without violating encapsulation, capture and externalize an object's internal state so that the object can be restored to this state later.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Memento pattern is used to capture an object's internal state and store it externally so that the object can be restored to this state later.
- In many graphics editing applications, the user can undo and redo operations.
- The Memento pattern can be used to store the state of the document before each operation and restore it when the user wants to undo the operation.

## Problem statement

- We would like to store the state of the bag when products are added to it.
- The Memento pattern can be used to store the state of the bag when products are added to it and restore the state when the user wants to undo the operation.

## Domain application

Memento:

- Stores internal state of the Originator object.
- The memento may store as much or as little of the originator's internal state as necessary at its originator's discretion.
- Protects against access by objects other than the originator.
- Mementos have effectively two interfaces.
- Caretaker sees a narrow interface to the Memento — it can only pass the memento to other objects.
- Originator, in contrast, sees a wide interface, one that lets it access all the data necessary to restore itself to its previous state.
- Ideally, only the originator that produced the memento would be permitted to access the memento's internal state.

```swift
struct BagState {
    let products: [Product]
}
```

Originator:

- Creates a memento containing a snapshot of its current internal state.
- Uses the memento to restore its internal state.

```swift
class Bag {
    private var products: [Product] = []

    func addProduct(_ product: Product) {
        products.append(product)
    }

    func removeProduct(_ product: Product) {
        products.removeAll { $0 == product }
    }

    func save() -> BagState {
        BagState(products: products)
    }

    func restore(from state: BagState) {
        products = state.products
    }
}
```

Caretaker:

- Is responsible for the memento's safekeeping.
- Never operates on or examines the contents of a memento.

```swift
class BagManager {
    private var bag: Bag
    private var mementos: [BagState] = []

    init(bag: Bag) {
        self.bag = bag
    }

    func addProduct(_ product: Product) {
        bag.addProduct(product)
        mementos.append(bag.save())
    }

    func undo() {
        guard let lastMemento = mementos.popLast() else { return }
        bag.restore(from: lastMemento)
    }
}
```
