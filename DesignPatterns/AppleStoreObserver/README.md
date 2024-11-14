![Observer](https://github.com/user-attachments/assets/12361209-cc92-4624-9ffb-3b9005a879d7)

<br />

# Observer

> Define a one-to-many dependency between objects so that when one object changes state, all its dependents are notified and updated automatically.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Observer pattern enables a specific object to notify a list of observer objects when a change in state occurs.

- The specific object is called the subject.

- The subject is able to attach, detach, and notify observers.

## Problem statement

- Each Apple Store customer's bag contains an array of products, which are stored on the server.

- When on the Apple Store bag list view, we would like to keep the array of products up to date, even if they are added or removed from another device.

- In the top navigation, we would also like the bag icon view badge count to be in sync with the bag product count.

- Both the bag icon view and bag list view need to be updated when products are added or removed.

- We would like to avoid having to check for changes in each individual view.

- The Observer pattern solves this problem by creating a single source of truth for the bag product array and notifying all observers when a change occurs.

- This allows for a decoupled design where there is a clear separation of concerns between the subject and the observers, conforming to the single responsibility principle.

## Definitions

#### Observer:

Defines the protocol for objects that would like to be notified of changes to the bag products.

```swift
protocol BagObserver: AnyObject {
    func bagUpdatedWithProducts(_ products: [Product])
}
```

#### Concrete observer:

- Maintains a reference to a subject.

- Stores state that should stay consistent with the subject.

- Implements the `bagUpdatedWithProducts` to update its state when the subject notifies it.

- In the example, we attach the observer to the subject in the initializer, and detach it in the deinitializer.

```swift
class BagListViewModel: BagObserver {
    private let notifier: BagNotifier
    private(set) var products: [Product] = []

    init(notifier: BagNotifier) {
        self.notifier = notifier
        self.notifier.attachObserver(self)
    }

    func bagUpdatedWithProducts(_ products: [Product]) {
        self.products = products
    }

    deinit {
        notifier.detachObserver(self)
    }
}

class BagIconViewModel: BagObserver {
    private let notifier: BagNotifier
    private(set) var badgeCount: Int = 0

    init(notifier: BagNotifier) {
        self.notifier = notifier
        self.notifier.attachObserver(self)
    }

    func bagUpdatedWithProducts(_ products: [Product]) {
        self.badgeCount = products.count
    }

    deinit {
        notifier.detachObserver(self)
    }
}
```

#### Subject:

Defines the protocol for managing observers.

```swift
protocol BagNotifier {
    func attachObserver(_ observer: BagObserver)
    func detachObserver(_ observer: BagObserver)
    func notify()
}
```

#### Concrete subject:

- Manages a list of observers.

- Stores the state of interest to observer objects.

- Sends a notification to its observers when its state changes.

```swift
class WebSocketBagNotifier: BagNotifier {
    private var observers: [BagObserver] = []
    private var products: [Product] = []

    func attachObserver(_ observer: BagObserver) {
        observers.append(observer)
    }

    func detachObserver(_ observer: BagObserver) {
        observers.removeAll { $0 === observer }
    }

    func notify() {
        observers.forEach { $0.bagUpdatedWithProducts(self.products) }
    }

    func testReceivingUpdatedBagProducts(_ product: [Product]) {
        self.products = product
        notify()
    }
}
```

## Application

```swift
struct Product {
    let id: String
    let name: String
    let price: Double
}

let notifier = WebSocketBagNotifier()
let bagListViewModel = BagListViewModel(notifier: notifier)
let bagIconViewModel = BagIconViewModel(notifier: notifier)

print(bagListViewModel.products) // []
print(bagIconViewModel.badgeCount) // 0

notifier.testReceivingUpdatedBagProducts([
    Product(id: "1", name: "iPad Pro", price: 999.99)
])

print(bagListViewModel.products) // [Product(id: "1", name: "iPad Pro", price: 999.99)]
print(bagIconViewModel.badgeCount) // 1
```
