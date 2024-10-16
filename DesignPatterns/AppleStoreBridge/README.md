![Bridge](https://github.com/user-attachments/assets/8d1e0afd-4f2c-4fe5-9000-01c540b1fad3)

<br />

# Bridge

> Decouple an abstraction from its implementation so that the two can vary independently.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Overview

- The Bridge pattern is a structural design pattern that decouples an abstraction from its implementation, allowing the two to evolve independently. This is particularly useful in scenarios where an abstraction can have multiple implementations, and those implementations can change over time.
- For example, consider a blog application that allows users to create and publish posts. The application may have a `Post` class that represents a blog post, and a `PostRenderer` class that renders the post in different formats (e.g., HTML, Markdown, etc.). The `Post` class may have a `render` method that delegates the rendering to the `PostRenderer` class. The `PostRenderer` class may have multiple implementations, such as `HtmlPostRenderer` and `MarkdownPostRenderer`, each of which renders the post in a different format.
- By using the Bridge pattern, we can decouple the `Post` class from the `PostRenderer` class, allowing the two to evolve independently. This makes it easier to add new rendering formats or change the existing ones without modifying the `Post` class.

## Elements

#### Abstraction: The high-level interface that defines the abstraction

```swift
protocol Abstraction {
    var implementation: Implementation { get set }
    func operation() -> String
}
```

#### Refined Abstraction: Extends the interface defined by the Abstraction

```swift
class RefinedAbstraction: Abstraction {
    var implementor: Implementor

    init(implementor: Implementor) {
        self.implementor = implementor
    }

    func operation() -> String {
        return implementation.operationImplementation()
    }
}
```

#### Implementor: Defines the interface for implementation classes

```swift
protocol Implementor {
    func operationImplementation() -> String
}
```

#### Concrete Implementor: Implements the Implementor interface and defines its concrete implementation

```swift
class ConcreteImplementorA: Implementor {
    func operationImplementation() -> String {
        return "ConcreteImplementationA"
    }
}
```

## Apple Store application

#### Abstraction

```swift
protocol PaymentBridge {
    func processPayment(amount: Double) async -> Result<String, Error>
}
```

#### Refined Abstraction

```swift
struct CheckoutPaymentBridge: PaymentBridge {
    let paymentProvider: PaymentProvider

    func processPayment(amount: Double) async -> Result<String, Error> {
        let result = await paymentProvider.processPayment(amount: amount)

        switch result {
        case .success(let message):
            return .success(message)
        case .failure(let error):
            return .failure(error)
        }
    }
}
```

#### Implementor

```swift
protocol PaymentProvider {
    func processPayment(amount: Double) async -> Result<String, Error>
}
```

#### Concrete Implementor

````swift
struct ApplePayPaymentProvider: PaymentProvider {
    func processPayment(amount: Double) async -> Result<String, Error> {
        return .success("Apple Pay payment succeeded.")
    }
}

struct VisaPaymentProvider: PaymentProvider {
    func processPayment(amount: Double) async -> Result<String, Error> {
        return .success("Visa payment succeeded.")
    }
}
````
