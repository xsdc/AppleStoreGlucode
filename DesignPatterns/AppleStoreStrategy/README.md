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

// RB: >>> I don't think you are capturing the problem here. You ask: "How can we design a system that allows users to select a payment method and process payments accordingly?" - very easily WITHOUT using the Strategy pattern. All I would need to do is switch on the payment type and implement the appropriate payment logic in my Checkout class. This issue here (i.e the problem) is this creates a violation of the Open Closed principle. 
- Consider a payment processing system where users can pay using different methods such as Apple Pay, credit card, or gift card.
- Each payment method has its own implementation and logic.
- How can we design a system that allows users to select a payment method and process payments accordingly?

## Domain application

Strategy:

- Declares an interface common to all supported algorithms.
- Context uses this interface to call the algorithm defined by a ConcreteStrategy.

```swift
protocol PaymentStrategy {
    // RB: // this is a grammatical phrase not a prepositional phrase so should read: `payAmount(_ Double)` See Swift API Guidelines. 
    func pay(amount: Double) async -> Result<String, Error>
}
```

ConcreteStrategy:

Implements the algorithm using the Strategy interface.

// RB: >>> Pop this code into an editor and you will immediately see the problem. a) Non of your concretes conform to the PaymentStrategy (they are missing a return type); b) non of them have inits (which they need), c) all of these should be Structs not classes. 

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

// RB: >>> Checkout needs an init, and paymentStrategy should be a constant. 

```swift
struct Checkout {
    var paymentStrategy: PaymentStrategy

    func processPayment(amount: Double) {
        paymentStrategy.pay(amount: amount)
    }
}
```
