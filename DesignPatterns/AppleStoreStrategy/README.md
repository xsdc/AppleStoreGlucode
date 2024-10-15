![Strategy](https://github.com/user-attachments/assets/d42ec330-9247-4b80-acc0-f08165898f43)

<br />

# Strategy

> Define a family of algorithms, encapsulate each one, and make them interchangeable. Strategy lets the algorithm vary independently from clients that use it.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Overview

- The Strategy pattern is used when you want to define a set of behaviors and make them interchangeable.
- For example, consider a `SortingStrategy` protocol that defines a `sort` method. You can have multiple implementations of this protocol, such as `BubbleSort`, `QuickSort`, and `MergeSort`, each with its own sorting algorithm.
-	This pattern promotes flexibility and reusability by allowing clients to choose the appropriate behavior.

## Definitions

#### Context: The object that uses the strategy

```swift
struct Context {
    var strategy: Strategy

    func executeStrategy() {
        strategy.execute()
    }
}
```

#### Strategy: A protocol that defines the interface for the different strategies

```swift
protocol Strategy {
    func execute()
}
```

#### Concrete Strategies: Specific implementations of the strategy interface

```swift
struct ConcreteStrategyA: Strategy {
    func execute() {
        print("Concrete Strategy A")
    }
}

struct ConcreteStrategyB: Strategy {
    func execute() {
        print("Concrete Strategy B")
    }
}
```

## Apple Store application

For the Apple Store, we can use the Strategy pattern to implement different payment strategies. The `PaymentStrategy` protocol defines the interface for the payment strategies, and the `Checkout` struct uses the selected payment strategy to process payments.

#### Context

```swift
struct Checkout {
    var selectedPaymentStrategy: PaymentStrategy

    mutating func updatePaymentStrategy(_ paymentStrategy: PaymentStrategy) {
        selectedPaymentStrategy = paymentStrategy
    }

    func processPayment(amount: Double) async -> Result<Bool, Error> {
        let result = await selectedPaymentStrategy.pay(amount: amount)

        return result
    }
}
```

#### Strategy

```swift
protocol PaymentStrategy {
    func pay(amount: Double) async -> Result<Bool, Error>
}
```

#### Concrete Strategies

```swift
struct ApplePayPaymentStrategy: PaymentStrategy {
    let appleId: String

    func pay(amount: Double) async -> Result<Bool, Error> {
        return .success(true)
    }
}

struct CreditCardPaymentStrategy: PaymentStrategy {
    let creditCardNumber: Int

    func pay(amount: Double) async -> Result<Bool, Error> {
        return .success(true)
    }
}

struct GiftCardPaymentStrategy: PaymentStrategy {
    let giftCard: String

    func pay(amount: Double) async -> Result<Bool, Error> {
        return .success(true)
    }
}
```

In the context of a payment processing system, the Strategy pattern allows for different payment methods to be implemented and used interchangeably. The Checkout struct represents the context that utilizes the selected payment strategy.

### Usage

```swift
var checkout = Checkout(selectedPaymentStrategy: ApplePayPaymentStrategy(appleId: "user@icloud.com"))

// Process payment with Apple Pay
let applePayResult = await checkout.processPayment(amount: 100.0)

// Update the payment strategy to credit card
checkout.updatePaymentStrategy(CreditCardPaymentStrategy(creditCardNumber: 1234567890))

// Process payment with credit card
let creditCardResult = await checkout.processPayment(amount: 150.0)
```
