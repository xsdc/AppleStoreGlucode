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

- When on the Apple Store bag view, we would like to keep the array of products up to date, even if they are added or removed from another device.

- In the top navigation, we would also like the bag icon badge count to be in sync with the bag product count.

- Without implementing the observer pattern, views would need to actively retrieve data in order to stay up to date.

- This may result in redundant fetching, or the views may end up out of sync with the underlying model.

- The Observer pattern solves this problem by creating a single source of truth for the bag product array and notifying all observers when a change occurs.

- This allows for a decoupled design where there is a clear separation of concerns between the subject and the observers.

## Definitions

#### Observer:

Defines the protocol for objects that would like to be notified of changes to the bag products.

```swift
protocol Observer {
    func notificationWithObject(_ object: Any)
}
```

#### Concrete observer:

- Maintains a reference to a subject.

- Stores state that should stay consistent with the subject.

- Implements the `bagUpdatedWithProducts` to update its state when the subject notifies it.

- We attach the observer to the subject in the initializer, and detach it in the deinitializer.

```swift
class BagListViewModel: Observer {
    var products: [Product] = []
    private let notifier: ObserverManagingNotifier

    init(notifier: ObserverManagingNotifier) {
        self.notifier = notifier
        self.notifier.attachObserver(self)
    }

    func notificationWithObject(_ object: Any) {
        if let products = object as? [Product] {
            self.products = products
        }
    }

    deinit {
        notifier.detachObserver(self)
    }
}

class BagIconViewModel: Observer {
    var badgeCount: Int = 0
    private let notifier: ObserverManagingNotifier

    init(notifier: ObserverManagingNotifier) {
        self.notifier = notifier
        self.notifier.attachObserver(self)
    }

    func notificationWithObject(_ object: Any) {
        if let products = object as? [Product] {
            self.badgeCount = products.count
        }
    }

    deinit {
        notifier.detachObserver(self)
    }
}
```

#### Subject:

- `ObserverManaging` defines the protocol for managing observers.

- `Notifier` defines the protocol for notifying observers.

```swift
protocol ObserverManagingNotifier {
    func attachObserver(_ observer: Observer)
    func detachObserver(_ observer: Observer)
    func notify()
}
```

#### Concrete subject:

- Manages a list of observers.

- Stores the state of interest to observer objects.

- Sends a notification to its observers when its state changes.

```swift
class WebSocketBagNotifier: ObserverManagingNotifier {
    private var observers: [Observer] = []
    private var products: [Product] = []

    func addProduct(_ product: Product) {
        self.products.append(product)
    }

    func attachObserver(_ observer: Observer) {
        observers.append(observer)
    }

    func detachObserver(_ observer: Observer) {
        // Remove observer from the list
    }

    func notify() {
        observers.forEach { $0.notificationWithObject(self.products) }
    }
}
```

## Example

```swift
struct Product {
    let name: String
    let price: Double
}

let notifier = WebSocketBagNotifier()
let bagListViewModel = BagListViewModel(notifier: notifier)
let bagIconViewModel = BagIconViewModel(notifier: notifier)

// Default values

print(bagListViewModel.products) // []
print(bagIconViewModel.badgeCount) // 0

notifier.addProduct(
    Product(name: "iPad Pro", price: 999.99)
)
notifier.notify()

// Values after product added to the bag

print(bagListViewModel.products) // [Product(name: "iPad Pro", price: 999.99)]
print(bagIconViewModel.badgeCount) // 1
```
