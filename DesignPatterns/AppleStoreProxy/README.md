![Proxy](https://github.com/user-attachments/assets/4c4a662b-7dfd-46a1-9122-3fc488a30ca1)

<br />

# Proxy

> Provide a surrogate or placeholder for another object to control access to it.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Proxy pattern provides a stand-in that controls access to another object.

- It is used in situations where you want to control access to a class without changing the class itself; or where the class is defined in a 3rd party library, and therefore can't be modified. 

- Common uses include protection/authorization (protection proxy), lazy initialization (virtual proxy), remote access (remote proxy), and caching.

## Problem statement

- Apple Store users are able to add and remove items from their bag.

- This is done in the `Bag` class.

- We need to ensure only authenticated users with the correct permission can modify the bag.

- We do not want to modify the `Bag` class itself.

- The Proxy pattern allows us to enforce access rules before delegating to the `Bag`, keeping responsibilities separate and the real subject unchanged.

## Definitions

#### Subject:

- Defines the common protocol for the real subject and the proxy.

- By defining a common protocol, we can use the proxy in place of the real subject.

- The proxy will control access to the real subject `Bag` by checking session state before delegating.

```swift
protocol ProductManaging {
    func addProduct(_ product: Product)
    func removeProduct(_ product: Product)
    func clearAllProducts()
}
```

#### Real subject:

- The object whose access we want to control.

- In our scenario, this is an existing `Bag` struct.

```swift
struct Bag: ProductManaging {
    func addProduct(_ product: Product) {
        print("Product added to bag")
    }

    func removeProduct(_ product: Product) {
        print("Product removed from bag")
    }

    func clearAllProducts() {
        print("Bag has been cleared")
    }
}
```

#### Proxy:

- Maintains a reference to the real subject, via dependency injection.

- Shares a protocol with the real subject so that the proxy can be used anywhere the real subject is expected.

- Enforces access checks (authentication/authorization) before delegating to the real subject.

```swift
struct UserSession {
    let isLoggedIn: Bool
    let canModifyBag: Bool
}

struct BagProtectionProxy: ProductManaging {
    private let bag: ProductManaging
    private let session: UserSession

    func addProduct(_ product: Product) {
        guard session.isLoggedIn && session.canModifyBag else {
            print("Access denied: insufficient permissions")
            return
        }
        bag.addProduct(product)
    }

    func removeProduct(_ product: Product) {
        guard session.isLoggedIn && session.canModifyBag else {
            print("Access denied: insufficient permissions")
            return
        }
        bag.removeProduct(product)
    }

    func clearAllProducts() {
        guard session.isLoggedIn && session.canModifyBag else {
            print("Access denied: insufficient permissions")
            return
        }
        bag.clearAllProducts()
    }
}
```

## Example

```swift
struct Product {
    let name: String
    let price: Double
}

let bag = Bag()

let deniedSession = UserSession(isLoggedIn: false, canModifyBag: false)
let deniedProxy = BagProtectionProxy(bag: bag, session: deniedSession)

deniedProxy.addProduct(
    Product(name: "iPhone", price: 999.99)
)

// Output:
// Access denied: insufficient permissions

let authorizedSession = UserSession(isLoggedIn: true, canModifyBag: true)
let authorizedProxy = BagProtectionProxy(bag: bag, session: authorizedSession)

authorizedProxy.addProduct(
    Product(name: "iPhone", price: 999.99)
)

// Output:
// Product added to bag

authorizedProxy.removeProduct(
    Product(name: "iPhone", price: 999.99)
)

// Output:
// Product removed from bag

authorizedProxy.clearAllProducts()

// Output:
// Bag has been cleared
```
