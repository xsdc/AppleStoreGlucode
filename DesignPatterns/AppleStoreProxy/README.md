![Proxy](https://github.com/user-attachments/assets/4c4a662b-7dfd-46a1-9122-3fc488a30ca1)

<br />

# Proxy

> Provide a surrogate or placeholder for another object to control access to it.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Proxy pattern provides a layer that may be used to add behaviour to a class.

- Common uses include controlling access to a class, adding logging, or to add caching.

- It is used in situations where you want to add behaviour to a class without changing the class itself.

## Problem statement

- Apple Store users are able to add and remove items from their bag.

- This is done in the `Bag` class.

- We would like to add event logging via an analytics service to the `Bag` class, but we do not want to modify the class itself.

- To avoid the issue of adding logging to the `Bag` class, we can use the Proxy pattern.

- The proxy pattern allows us to separate the analytics logic from the `Bag` class, adhering to the single responsibility principle.

## Definitions

#### Real subject:

- The object to which we want to add behavior.

- In our scenario, this is an existing `Bag` struct to which we would like to add analytics.

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

#### Subject:

- Defines the common protocol for the real subject and the proxy.

- By defining a common protocol, we can use the proxy in place of the real subject.

- The proxy will be used to add the additional analytics behaviour to the real subject `Bag`, without changing it.

```swift
protocol ProductManaging {
    func addProduct(_ product: Product)
    func removeProduct(_ product: Product)
    func clearAllProducts()
}
```

#### Proxy:

- Maintains a reference to the real subject, via dependency injection.

- Share a protocol with the real subject so that the proxy can be used anywhere the real subject is expected.

- We can now add the analytics behaviour to the proxy without changing the real subject, while still making use of its functionality.

```swift
struct BagWithAnalyticsProxy: ProductManaging {
    let bag: ProductManaging

    func addProduct(_ product: Product) {
        bag.addProduct(product)

        logAnalyticsEvent(withID: "productAddedFromBag")
    }

    func removeProduct(_ product: Product) {
        bag.removeProduct(product)

        logAnalyticsEvent(withID: "productRemovedFromBag")
    }

    func clearAllProducts() {
        bag.clearAllProducts()

        logAnalyticsEvent(withID: "allProductsRemovedFromBag")
    }

    private func logAnalyticsEvent(withID id: String) {
        print("Analytics event logged with identifier: \(id)")
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
let bagWithAnalyticsProxy = BagWithAnalyticsProxy(bag: bag)

bagWithAnalyticsProxy.addProduct(
    Product(name: "iPhone", price: 999.99)
)

// Output:
// Product added to bag
// Analytics event logged with identifier: productAddedFromBag

bagWithAnalyticsProxy.removeProduct(
    Product(name: "iPhone", price: 999.99)
)

// Output:
// Product removed from bag
// Analytics event logged with identifier: productRemovedFromBag

bagWithAnalyticsProxy.clearAllProducts()

// Output:
// Bag has been cleared
// Analytics event logged with identifier: allProductsRemovedFromBag
```
