![Strategy](https://github.com/user-attachments/assets/94c6b446-531f-4942-87bc-e3c17fe0392b)

<br />

# Strategy

> Define a family of algorithms, encapsulate each one, and make them interchangeable. Strategy lets the algorithm vary independently from clients that use it.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Strategy pattern is used when you want to define a set of behaviors and make them interchangeable.
- For example, consider a `SortingStrategy` protocol that defines a `sort` method. You can have multiple implementations of this protocol, such as `BubbleSort`, `QuickSort`, and `MergeSort`, each with its own sorting algorithm.
-	This pattern promotes flexibility and reusability by allowing the behavior to be selected according to a common interface.

## Problem statement

- Consider a payment processing system where users can pay using different methods such as Apple Pay, credit card, or gift card.
- Each payment method has its own implementation and logic.
- How can we design a system that allows users to select a payment method and process payments accordingly?

## Domain application

Strategy:

- Declares an interface common to all supported algorithms.
- Context uses this interface to call the algorithm defined by a ConcreteStrategy.

```swift
protocol PaymentStrategy {
    func pay(amount: Double) async -> Result<String, Error>
}
```

ConcreteStrategy:

Implements the algorithm using the Strategy interface.

```swift
class ApplePayPaymentStrategy: PaymentStrategy {
    let appleId: String

    func pay(amount: Double) {
        // Process Apple Pay payment
    }
}

class CreditCardPaymentStrategy: PaymentStrategy {
    let creditCardNumber: Int

    func pay(amount: Double) {
        // Process credit card
    }
}

class GiftCardPaymentStrategy: PaymentStrategy {
    let giftCard: String

    func pay(amount: Double) {
        // Process gift card
    }
}
```

Context:

- Is configured with a ConcreteStrategy object.
- Maintains a reference to a Strategy object.
- May define an interface that lets Strategy access its data.

```swift
struct Checkout {
    var paymentStrategy: PaymentStrategy

    func processPayment(amount: Double) {
        paymentStrategy.pay(amount: amount)
    }
}
```
