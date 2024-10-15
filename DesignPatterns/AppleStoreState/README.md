<br />

# State

> Allow an object to alter its behavior when its internal state changes. The object will appear to change its class.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Overview

- The State pattern allows object behavioral change based on its current state. This is often seen in applications where an object can be in multiple states, and each state has different behaviors associated with it.
- For example, a `MusicPlayerButton` object can be in multiple states, such as `PlayingState`, `PausedState`, and `StoppedState`, each with its own behavior.
- The State pattern encapsulates the state-specific behavior in separate classes, allowing for cleaner and more maintainable code.

## Definitions

#### Context: The object that has a state and can change its behavior

```swift
struct Context {
    var state: State

    func updateState(_ state: State) {
        self.state = state
    }

    func performAction() {
        state.action()
    }
}
```

#### State: A protocol that defines the interface for the various states

```swift
protocol State {
    var context: Context { get set }

    func action()
}
```

#### Concrete States: Specific implementations of the state interface
```swift
struct StateA: State {
    var context: Context

    func action() {
        print("State A action")
    }
}

struct StateB: State {
    var context: Context

    func action() {
        print("State B action")
    }
}
```

## Apple Store application

- The State pattern can be applied to the Apple Store to manage the state of an order. An order can be in multiple states, such as `Pending`, `Shipped`, and `Cancelled`, each with its own behavior.
- The `OrderState` protocol defines the functions that illustrates how calling the same function can have different behavior based on the state of the order.
- The `NotificationService` implementation further illustrates how the state change can trigger different behavior. The example shows how messages sent depend on the current state.

#### Context

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

#### State

```swift
protocol OrderState {
    func getStateName() -> String
    func getStateDescription() -> String
    mutating func shipOrder()
    mutating func cancelOrder()
}
```

#### Concrete States

```swift
struct PendingOrderState: OrderState {
    var order: Order

    func getStateName() -> String {
        return "Pending"
    }

    func getStateDescription() -> String {
        return "Order #\(order.id)"
    }

    mutating func shipOrder() {
        order.notificationService.sendMessage("Order #\(order.id) has been shipped.")
        order.update(state: ShippedOrderState(order: order))
    }

    mutating func cancelOrder() {
        order.notificationService.sendMessage("Order #\(order.id) has been cancelled.")
        order.update(state: CancelledOrderState(order: order))
    }
}

struct ShippedOrderState: OrderState {
    var order: Order

    func getStateName() -> String {
        return "Shipped"
    }

    func getStateDescription() -> String {
        return "Order #\(order.id) is on the way."
    }

    mutating func shipOrder() {
        order.notificationService.sendMessage("Order #\(order.id) is already on the way.")
    }

    mutating func cancelOrder() {
        order.notificationService.sendMessage("Order #\(order.id) has been cancelled, and will return to Apple.")
        order.update(state: CancelledOrderState(order: order))
    }
}

struct CancelledOrderState: OrderState {
    var order: Order

    func getStateName() -> String {
        return "Cancelled"
    }

    func getStateDescription() -> String {
        return "Order #\(order.id) has been cancelled."
    }

    mutating func shipOrder() {
        order.notificationService.sendMessage("Order #\(order.id) has been shipped.")
        order.update(state: ShippedOrderState(order: order))
    }

    mutating func cancelOrder() {
        order.notificationService.sendMessage("Order #\(order.id) has already been cancelled.")
    }
}
```

### Usage

```swift
let notificationService = NotificationService()
let order = Order(id: "12345", notificationService: notificationService, orderState: PendingOrderState(order: order))

// Ship the order
order.orderState.shipOrder()

// Cancel the order
order.orderState.cancelOrder()
```
