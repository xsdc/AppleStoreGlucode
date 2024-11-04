![Observer](https://github.com/user-attachments/assets/12361209-cc92-4624-9ffb-3b9005a879d7)

<br />

# Observer

> Define a one-to-many dependency between objects so that when one object changes state, all its dependents are notified and updated automatically.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Observer pattern defines a one-to-many dependency between objects so that when one object changes state, all its dependents are notified and updated automatically.
- For example, in a database driven application, the data layer can notify the UI layer when a record is updated.

## Problem statement

- We would like to keep the bag badge count up to date.
- The observer pattern allows us to notify the bag icon view with the updated badge count when a product is added or removed.

## Domain application

Subject:

- Knows its observers. Any number of Observer objects may observe a subject.
- Provides an interface for attaching and detaching Observer objects.

```swift
protocol BagNotifier {
    func attach(observer: BagObserver)
    func detach(observer: BagObserver)
    func notify()
}
```

Observer:

Defines an updating interface for objects that should be notified of changes in a subject.

```swift
protocol BagObserver {
    func updateBagCount(_ count: Int)
}
```

ConcreteSubject:

- Stores state of interest to ConcreteObserver objects.
- Sends a notification to its observers when its state changes.

```swift
class BagService: BagNotifier {
    private var observers: [BagObserver] = []
    private var badgeCount: Int = 0

    func attach(observer: BagObserver) {
        observers.append(observer)
    }

    func detach(observer: BagObserver) {
        observers = observers.filter { $0 !== observer }
    }

    func notify() {
        observers.forEach { $0.update(count: badgeCount) }
    }

    func addProduct() {
        badgeCount += 1
        notify()
    }
}
```

ConcreteObserver:

- Maintains a reference to a ConcreteSubject object.
- Stores state that should stay consistent with the subject's.
- Implements the Observer updating interface to keep its state consistent with the subject's.

```swift
class BagIconView: BagObserver {
    func updateBagCount(_ count:) {
        // Update the badge count
    }
}
```
