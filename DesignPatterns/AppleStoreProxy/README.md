![Proxy](https://github.com/user-attachments/assets/4c4a662b-7dfd-46a1-9122-3fc488a30ca1)

<br />

# Proxy

> Provide a surrogate or placeholder for another object to control access to it.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Proxy pattern provides a layer that may be used to add behavior to a class.

- Common uses include controlling access to a class, adding logging, or to add caching.

- It is used in situations where you want to add behavior to a class without changing the class itself.

## Problem statement

- Apple Store users are able to clear all items added to their bag.

- We currently have an object dedicated to clearing the bag called `BagClearer`.

- Let's assume that authentication is currently handled in the bag clearing object.

- We would like to avoid this problem, and opt for a more modular approach that conforms to the single responsibility principle.

- The proxy pattern allows us to separate the authentication logic from the bag clearing object, and treat it as a separate concern.

## Definitions

#### Subject:

- Defines the common protocol for the real subject and the proxy.

- By defining a common protocol, authentication can be separated from the real subject.

```swift
protocol BagClearing {
    func clearBag()
}
```

#### Real subject:

- The object that we want to add behavior to.

- We are now able to separate the authentication logic from the real subject.

```swift
struct BagClearer: BagClearing {
    func clearBag() {
        print("Bag has been cleared")
    }
}
```

#### Proxy:

- Maintains a reference to the real subject.

- Share a protocol with the real subject so that the proxy can be used anywhere the real subject is expected.

- We can now add the authentication logic without changing the core functionality of the `BagClearer` object.

```swift
struct BagClearerWithAuthentication: BagClearing {
    let bagClearer: BagClearer

    func clearBag() {
        if checkIfAuthenticated() {
            bagClearer.clearBag()
        }
        else {
            print("Authentication required to clear bag")
        }
    }

    private func checkIfAuthenticated() -> Bool {
        return false
    }
}
```

## Example

```swift
let bagClearer = BagClearer()
bagClearer.clearBag() // Bag has been cleared

let bagClearerWithAuthentication = BagClearerWithAuthentication(bagClearer: bagClearer)
bagClearerWithAuthentication.clearBag() // Authentication required to clear bag
```
