![Strategy](https://github.com/user-attachments/assets/94c6b446-531f-4942-87bc-e3c17fe0392b)

<br />

# Strategy

> Define a family of algorithms, encapsulate each one, and make them interchangeable. Strategy lets the algorithm vary independently from clients that use it.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Strategy pattern is used when you want to define a set of behaviours and make them interchangeable.

-	By establishing a common protocol for all behaviours, you can create multiple implementations that can be swapped seamlessly.

## Problem statement

- The Apple Store needs to support multiple payment methods.

- These include payment methods such as Apple Pay, Mastercard, Visa, and gift cards.

- In the future, we may need to add or remove payment methods and their processing logic without changing existing code.

- We would like to avoid the situation where we have to modify existing code to accommodate changes to payment methods.

- The Strategy pattern helps us achieve this by defining a common protocol for all payment methods.

- Each concrete strategy will implement the payment processing logic for a specific payment method.

- This allows for scalable and maintainable code that adheres to the open/closed principle, and the single responsibility principle.

## Definitions

#### Strategy:

Defines the unified protocol for all supported payment methods.

```swift
protocol PaymentStrategy {
    func pay(amount: Double)
}
```

#### Concrete strategy:

Implement the payment logic for each specific payment method.

```swift
struct ApplePayPaymentStrategy: PaymentStrategy {
    let appleId: String

    func pay(amount: Double) {
        print("Processing Apple Pay payment of R\(amount)")
    }
}

struct CreditCardPaymentStrategy: PaymentStrategy {
    let creditCardNumber: String

    func pay(amount: Double) {
        print("Processing credit card payment of R\(amount)")
    }
}
```

#### Context:

Holds a reference to a `PaymentStrategy` and delegates the payment processing to it.

```swift
struct Checkout {
    let paymentStrategy: PaymentStrategy

    func processPayment(amount: Double) {
        paymentStrategy.pay(amount: amount)
    }
}
```

## Application

```swift
let applePayStrategy = ApplePayPaymentStrategy(appleId: "4321")
let creditCardStrategy = CreditCardPaymentStrategy(creditCardNumber: "1234567890")

let applePayCheckout = Checkout(paymentStrategy: applePayStrategy)
applePayCheckout.processPayment(amount: 72000.00) // Processing Apple Pay payment of R72000.00

let creditCardCheckout = Checkout(paymentStrategy: creditCardStrategy)
creditCardCheckout.processPayment(amount: 64000.00) // Processing credit card payment of R64000.00
```
