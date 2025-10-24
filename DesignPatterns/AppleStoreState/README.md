![State](https://github.com/user-attachments/assets/ba018cdd-d8e8-43b9-a0d5-81ccd5c04f52)

<br />

# State

> Allow an object to alter its behavior when its internal state changes. The object will appear to change its class.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The State pattern is concerned with keeping track of the state of an object and changing its behavior based on that state.

- To illustrate, consider a video player that can be in one of two states: playing or paused.

- The play/pause button should behave differently based on the current state of the player.

- Play when paused, and pause when playing.

## Problem statement

- We would like to implement connection status handling for Apple Store product views.

- The view models should be able to observe the reachability status and update their state accordingly.

- For simplicity, we will start with implementating three states: initial, connection reachable, and connection unreachable.

- We may encounter the problem of having multiple if-else statements to manage the state transitions.

- When adding more states in the future, the code will become complex and difficult to maintain.

- The State pattern helps us manage state changes in a more modular and maintainable way.

- We are able to have tailored behavior for each state update, and can easily add new states without modifying existing code.

## Definitions

#### Context:

- Maintains a reference to the current state.

- Responsible for delegating the state-specific behavior to the current state object.

- The functionality may vary based on the current state, even when the same method is called.

```swift
class ProductViewModel {
    var showNoInternetConnectionAlert = false
    var requests: [ServiceRequest] = []
    private var state: State

    init(state: State = InitialState()) {
        self.state = state
    }

    func updateConnection(toReachable isReachable: Bool) {
        if isReachable {
            state.connectionDidBecomeReachable(for: self)
            state = ConnectionReachableState()
        }
        else {
            state.connectionDidBecomeUnreachable(for: self)
            state = ConnectionUnreachableState()
        }
    }
}
```

#### State:

Defines the protocol for the state transitions.

```swift
protocol State {
    func connectionDidBecomeReachable(for viewModel: ProductViewModel)
    func connectionDidBecomeUnreachable(for viewModel: ProductViewModel)
}
```

#### Concrete state subclasses:

- Implementations for the state updates.

- We use the State pattern to manage the state of the `ProductViewModel` object based on the reachability status.

```swift
class InitialState: State {
    func connectionDidBecomeReachable(for viewModel: ProductViewModel) {
        viewModel.showNoInternetConnectionAlert = false
    }

    func connectionDidBecomeUnreachable(for viewModel: ProductViewModel) {
        viewModel.showNoInternetConnectionAlert = true

        for index in viewModel.requests.indices {
            viewModel.requests[index].isSuspended = true
        }
    }
}

class ConnectionUnreachableState: State {
    func connectionDidBecomeReachable(for viewModel: ProductViewModel) {
        viewModel.showNoInternetConnectionAlert = false

        for index in viewModel.requests.indices {
            viewModel.requests[index].isSuspended = false
        }
    }

    func connectionDidBecomeUnreachable(for viewModel: ProductViewModel) {
        viewModel.showNoInternetConnectionAlert = true
    }
}

class ConnectionReachableState: State {
    func connectionDidBecomeReachable(for viewModel: ProductViewModel) {
        viewModel.showNoInternetConnectionAlert = false
    }

    func connectionDidBecomeUnreachable(for viewModel: ProductViewModel) {
        viewModel.showNoInternetConnectionAlert = true

        for index in viewModel.requests.indices {
            viewModel.requests[index].isSuspended = true
        }
    }
}
```

## Example

```swift
struct ServiceRequest {
    let id: Int
    var isSuspended: Bool
}

let viewModel = ProductViewModel() // InitialState assigned
viewModel.requests = [
    ServiceRequest(id: 1, isSuspended: false),
    ServiceRequest(id: 2, isSuspended: false)
]

print(viewModel.showNoInternetConnectionAlert) // false
print(viewModel.requests) // [ServiceRequest(id: 1, isSuspended: false), ServiceRequest(id: 2, isSuspended: false)]

// InitialState.connectionDidBecomeUnreachable called, ConnectionUnreachableState assigned
viewModel.updateConnection(toReachable: false)

print(viewModel.showNoInternetConnectionAlert) // true
print(viewModel.requests) // [ServiceRequest(id: 1, isSuspended: true), ServiceRequest(id: 2, isSuspended: true)]

// ConnectionUnreachableState.connectionDidBecomeReachable called, ConnectionReachableState assigned
viewModel.updateConnection(toReachable: true)

print(viewModel.showNoInternetConnectionAlert) // false
print(viewModel.requests) // [ServiceRequest(id: 1, isSuspended: false), ServiceRequest(id: 2, isSuspended: false)]

// ConnectionReachableState.connectionDidBecomeUnreachable called, ConnectionUnreachableState assigned
viewModel.updateConnection(toReachable: false)

print(viewModel.showNoInternetConnectionAlert) // true
print(viewModel.requests) // [ServiceRequest(id: 1, isSuspended: true), ServiceRequest(id: 2, isSuspended: true)]
```
