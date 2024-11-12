![Strategy](https://github.com/user-attachments/assets/94c6b446-531f-4942-87bc-e3c17fe0392b)

<br />

# Strategy

> Define a family of algorithms, encapsulate each one, and make them interchangeable. Strategy lets the algorithm vary independently from clients that use it.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Strategy pattern is used when you want to define a set of behaviors and make them interchangeable.

-	By establishing a common protocol for all behaviors, you can create multiple implementations that can be swapped seamlessly.

## Illustrative example

- Suppose we are developing a sorting algorithm that can be used in different contexts.

- We define a protocol called `SortStrategy` that declares a method called `sort` that takes an array of integers and returns a sorted array.

- We can have multiple implementations of this protocol, such as `BubbleSort`, `QuickSort`, and `MergeSort`, each with its own sorting algorithm.

## Apple Store: Problem statement

- We would like to support multiple payment methods, such as Apple Pay or credit cards.

- Each payment method has its own payment processing logic.

- The Strategy pattern will allow us to add or remove payment methods in the future without changing the existing code.

## Apple Store: Application

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
class Checkout {
    private let paymentStrategy: PaymentStrategy

    init(paymentStrategy: PaymentStrategy) {
        self.paymentStrategy = paymentStrategy
    }

    func setPaymentStrategy(_ strategy: PaymentStrategy) {
        self.paymentStrategy = strategy
    }

    func processPayment(amount: Double) {
        paymentStrategy.pay(amount: amount)
    }
}
```

## Apple Store: Usage

```swift
let applePayStrategy = ApplePayPaymentStrategy(appleId: "4321")
let creditCardStrategy = CreditCardPaymentStrategy(creditCardNumber: "1234567890")

let applePayCheckout = Checkout(paymentStrategy: applePayStrategy)
applePayCheckout.processPayment(amount: 72000.00) // Processing Apple Pay payment of R72000.00

let creditCardCheckout = Checkout(paymentStrategy: creditCardStrategy)
creditCardCheckout.processPayment(amount: 64000.00) // Processing credit card payment of R64000.00
```
