![State](https://github.com/user-attachments/assets/ba018cdd-d8e8-43b9-a0d5-81ccd5c04f52)

<br />

# State

> Allow an object to alter its behavior when its internal state changes. The object will appear to change its class.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The State pattern allows object behavioral change based on its current state. This is often seen in applications where an object can be in multiple states, and each state has different behaviors associated with it.
- For example, a `MusicPlayerButton` object can be in multiple states, such as `PlayingState`, `PausedState`, and `StoppedState`, each with its own behavior.
- The State pattern encapsulates the state-specific behavior in separate classes, allowing for cleaner and more maintainable code.

## Problem statement

- The State pattern can be applied to the Apple Store to manage the state of an order. An order can be in multiple states, such as `Pending`, `Shipped`, and `Cancelled`, each with its own behavior.
- The `OrderState` protocol defines the functions that illustrates how calling the same function can have different behavior based on the state of the order.
- The `NotificationService` implementation illustrates how the current state can trigger different messages to be sent.

## Domain application

Context:

- Defines the interface of interest to clients.
- Maintains an instance of a ConcreteState subclass that defines the current state.

```swift
struct Order {
    let id: String
    let notificationService: NotificationService
    var orderState: OrderState

    mutating func update(state: OrderState) {
        orderState = state
    }
}
```

State:

Defines an interface for encapsulating the behavior associated with a particular state of the Context.

```swift
protocol OrderState {
    mutating func shipOrder()
    mutating func cancelOrder()
}
```

ConcreteState subclasses:

Each subclass implements a behavior associated with a state of the Context.

```swift
struct PendingOrderState: OrderState {
    mutating func shipOrder(order: Order) {
        order.notificationService.sendMessage("Order #\(order.id) has been shipped.")
        order.update(state: ShippedOrderState(order: order))
    }

    mutating func cancelOrder(order: Order) {
        order.notificationService.sendMessage("Order #\(order.id) has been cancelled.")
        order.update(state: CancelledOrderState(order: order))
    }
}

struct ShippedOrderState: OrderState {
    mutating func shipOrder(order: Order) {
        order.notificationService.sendMessage("Order #\(order.id) is already on the way.")
    }

    mutating func cancelOrder(order: Order) {
        order.notificationService.sendMessage("Order #\(order.id) has been cancelled, and will return to Apple.")
        order.update(state: CancelledOrderState(order: order))
    }
}

struct CancelledOrderState: OrderState {
    mutating func shipOrder(order: Order) {
        order.notificationService.sendMessage("Order #\(order.id) has been shipped.")
        order.update(state: ShippedOrderState(order: order))
    }

    mutating func cancelOrder(order: Order) {
        order.notificationService.sendMessage("Order #\(order.id) has already been cancelled.")
    }
}
```
