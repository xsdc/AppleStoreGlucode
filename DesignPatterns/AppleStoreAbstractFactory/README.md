![AbstractFactory](https://github.com/user-attachments/assets/b994e2b8-e2c2-4f9a-9ae7-704473dfc240)

<br />

# Abstract Factory

> Provide an interface for creating families of related or dependent objects without specifying their concrete classes.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Abstract Factory pattern provides an interface for creating families of related or dependent objects without specifying their concrete classes.
- A common example of the Abstract Factory pattern is a user interface toolkit, where the factory can create different types of buttons, menus, and windows.
- The Abstract Factory pattern is similar to the Factory Method pattern, but it creates an entire family of products instead of a single product.

## Problem statement

>>> RB: This problems statement doesn't specify the actual problem. If I didn't use an abstract factory what would I be forced to do, and why is that bad?

- For the Apple Store, consider categories of products such as iPhones, iPads, and MacBooks.
- Each category has different models. For iPad: iPad mini, iPad Air, iPad Pro, and iPad.
- Each model has different configurations.
- We can use the abstract factory pattern to create a factory for each category of products.

## Domain application

Abstract Factory:

Declares an interface for operations that create abstract product objects.

>>> RB: SeriesFactory isn't used anywhere else in your code examples.

```swift
protocol SeriesFactory {
    func createProductA() -> AbstractProductA
    func createProductB() -> AbstractProductB
}
```

Concrete Factory:

Implements the operations to create concrete product objects.

```swift
class AppleFactory: MacFactory, WatchFactory {
    func createMacBookPro() -> Mac {
        return MacBookPro()
    }

    func createMacBookAir() -> Mac {
        return MacBookAir()
    }

    func createAppleWatchSeries() -> AppleWatch {
        return AppleWatchSeries()
    }

    func createAppleWatchUltra() -> AppleWatch {
        return AppleWatchUltra()
    }
}
```

AbstractProduct:

Declares an interface for a type of product object.

>>> RB: your code examples need to align with what you are demonstrating. usefulFunctionA returning a String doesn't make sense. In a real world example, what properties and methods would this protocol define? Use those instead. You can keep it barebones, but the examples need to map to real world application otherwise its confusing.  

```swift
protocol AbstractProductA {
    func usefulFunctionA() -> String
}
```

ConcreteProduct:

- Defines a product object to be created by the corresponding concrete factory.
- Implements the AbstractProduct interface.

>>> RB: See comment above re. usefulFunction.

```swift
class ConcreteProductA1: AbstractProductA {
    func usefulFunctionA() -> String {
        return "The result of the product A1."
    }
}
```

Client:

>>> RB: AbstractFactory and AbstractProduct classes don't define interfaces. So what do you mean below exactly? 

Uses only interfaces declared by AbstractFactory and AbstractProduct classes.

```swift
class Client {
    private var productA: AbstractProductA
    private var productB: AbstractProductB

    init(factory: AbstractFactory) {
        productA = factory.createProductA()
        productB = factory.createProductB()
    }

    func run() {
        print(productA.usefulFunctionA())
        print(productB.usefulFunctionB())
    }
}
```

>>> RB: Overall I was able to grasp the concept with 80% clarity. 
