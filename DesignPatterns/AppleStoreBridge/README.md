![Bridge](https://github.com/user-attachments/assets/8d1e0afd-4f2c-4fe5-9000-01c540b1fad3)

<br />

# Bridge

> Decouple an abstraction from its implementation so that the two can vary independently.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Bridge pattern is a structural design pattern that decouples an abstraction from its implementation, allowing the two to evolve independently. This is particularly useful in scenarios where an abstraction can have multiple implementations, and those implementations can change over time.
- For example, consider a blog application that allows users to create and publish posts.
- The application may have a `Post` class that represents a blog post, and a `PostRenderer` class that renders the post in different formats (e.g., HTML, Markdown, etc.). The `Post` class may have a `render` method that delegates the rendering to the `PostRenderer` class.
- The `PostRenderer` class may have multiple implementations, such as `HtmlPostRenderer` and `MarkdownPostRenderer`, each of which renders the post in a different format.
- By using the Bridge pattern, we can decouple the `Post` class from the `PostRenderer` class, allowing the two to evolve independently.
- This makes it easier to add new rendering formats or change the existing ones without modifying the `Post` class.

## Problem statement

- We would like to develop the checkout and payment handling separately.
- The Bridge pattern allows us to do this by decoupling the payment processing and checkout implementations.
- This allows us to change the payment providers independently.

## Domain application

Abstraction:

- The high-level interface that defines the abstraction
- Maintains a reference to an object of type Implementor.

```swift
protocol PaymentBridge {
    func processPayment(amount: Double) async -> Result<String, Error>
    func updateAddress(_ address: String)
}
```

Refined Abstraction:

Extends the interface defined by the Abstraction.

```swift
class Checkout: PaymentBridge {
    let paymentProvider: PaymentProvider

    init(paymentProvider: PaymentProvider) {
        self.paymentProvider = paymentProvider
    }

    func processPayment(amount: Double) async -> Result<String, Error> {
        let result = await paymentProvider.processPayment(amount: amount)

        switch result {
        case .success(let message):
            return .success(message)
        case .failure(let error):
            return .failure(error)
        }
    }

    func updateAddress(_ address: String) {
        // Other features can be added that relate to the Checkout
    }
}
```

Implementor:

- Defines the interface for implementation classes.
- This interface doesn't have to correspond exactly to Abstraction's interface; in fact the two interfaces can be quite different.
- Typically the Implementor interface provides only primitive operations, and Abstraction defines higher-level operations based on these primitives.

```swift
protocol PaymentProvider {
    func processPayment(amount: Double) async -> Result<String, Error>
}
```

Concrete Implementor:

Implements the Implementor interface and defines its concrete implementation.

````swift
class ApplePayPaymentProvider: PaymentProvider {
    func processPayment(amount: Double) async -> Result<String, Error> {
        return .success("Apple Pay payment succeeded.")
    }
}

class CreditCardPaymentProvider: PaymentProvider {
    func processPayment(amount: Double) async -> Result<String, Error> {
        return .success("Visa payment succeeded.")
    }
}
````
