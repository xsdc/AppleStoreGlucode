![Facade](https://github.com/user-attachments/assets/9b3ca4a3-ab1e-4a2f-828c-491282b6614c)

<br />

# Facade

> Provide a unified interface to a set of interfaces in a subsystem. Facade defines a higher-level interface that makes the subsystem easier to use.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Facade pattern is a structural pattern that provides a simplified interface to a complex system of classes.
- For example, a Mac has many subsystems such as CPU, memory, storage, etc.
- The Facade pattern provides a unified interface to these subsystems.

## Problem statement

- We have services that are separate but often used together.
- By providing a simple interface to these services, we can reduce the complexity of the client code.
- This pattern is also useful for testing the subsystems in isolation and how they may interact with each other.

## Domain application

Facade:

- Knows which subsystem classes are responsible for a request.
- Delegates client requests to appropriate subsystem objects.

```swift
class OrderProccessor {
    private let bag: Bag
    private let paymentService: PaymentService

    init(bagService: Bag, paymentService: PaymentService) {
        self.bag = bag
        self.paymentService = paymentService
    }

    func processOrder() {
        paymentService.processPaymentWithBag(bag)
    }
}
```

Subsystem classes:

- Implement subsystem functionality.
- Handle work assigned by the Facade object.
- Have no knowledge of the facade; that is, they keep no references to it.

```swift
struct Bag {
    var products: [Product]

    addProduct(_ product: Product) {
        products.append(product)
    }

    removeProduct(_ product: Product) {
        products.removeAll { $0.id == product.id }
    }
}

class PaymentService {
    func processPaymentWithBag(_ bag: Bag) {
        // Process payment
    }
}
```
