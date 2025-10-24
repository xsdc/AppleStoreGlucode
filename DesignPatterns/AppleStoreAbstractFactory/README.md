![AbstractFactory](https://github.com/user-attachments/assets/b994e2b8-e2c2-4f9a-9ae7-704473dfc240)

<br />

# Abstract Factory

> Provide an interface for creating families of related or dependent objects without specifying their concrete classes.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Abstract Factory pattern enables the creation of families of related objects.

- It can be seen as an extension of the Factory Method pattern.

## Problem statement

For the Apple Store app, we encounter the need to create components that vary based on the device they are displayed on.

- Directly handling these variations can lead to complex and hard-to-maintain code containing conditional statements.

- This poses a risk of introducing bugs if each variation is not handled separately.

- The Abstract Factory pattern can be used to create a system that can create specific components for specific devices.

- Usage of the code is encapsulated in a factory object, which can be easily replaced with another factory object to create components for a different device.

- By determining the factory type at runtime, we can create components for different devices without changing the client code.

## Definitions

#### Abstract products:

- Declare protocols for components we want to create.

- Collectively, these protocols define a group of products that make up a product family.

- We've kept it simple by only including two components: a carousel and a bento box.

```swift
protocol CarouselView {
    func stopCarousel()
    func startCarousel()
}

protocol BentoBoxView {
    enum BentoBoxType {
        case small
        case medium
        case large
    }

    var type: BentoBoxType { get }
}
```

#### Concrete products:

- Concrete implementations of the abstract products.

- Each product must implement the interface of its family.

- For simplicity, we have two families of products: iPhone and iPad.

```swift
struct IPhoneCarouselView: CarouselView {
    func stopCarousel() {
        print("iPhone carousel stopped")
    }

    func startCarousel() {
        print("iPhone carousel started")
    }
}

struct IPadCarouselView: CarouselView {
    func stopCarousel() {
        print("iPad carousel stopped")
    }

    func startCarousel() {
        print("iPad carousel started")
    }
}

struct IPhoneBentoBoxView: BentoBoxView {
    let type: BentoBoxType
}

struct IPadBentoBoxView: BentoBoxView {
    let type: BentoBoxType
}
```

#### Abstract factory:

- Declares a protocol for each product family.

- Each protocol declares a set of methods for creating each product.

```swift
protocol AbstractComponentFactory {
    func makeCarouselView() -> CarouselView
    func makeBentoBoxView(type: BentoBoxView.BentoBoxType) -> BentoBoxView
}
```

#### Concrete factory:

Implements the protocol declared by the abstract factory.

```swift
class IPhoneComponentFactory: AbstractComponentFactory {
    func makeCarouselView() -> CarouselView {
        return IPhoneCarouselView()
    }

    func makeBentoBoxView(type: BentoBoxView.BentoBoxType) -> BentoBoxView {
        return IPhoneBentoBoxView(type: type)
    }
}

class IPadComponentFactory: AbstractComponentFactory {
    func makeCarouselView() -> CarouselView {
        return IPadCarouselView()
    }

    func makeBentoBoxView(type: BentoBoxView.BentoBoxType) -> BentoBoxView {
        return IPadBentoBoxView(type: type)
    }
}
```

#### Client:

- The client uses the abstract factory to create products.

- These can be used without knowing the specific classes of the products.

```swift
class ProductView {
    private let carouselView: CarouselView
    private let bentoBoxView: BentoBoxView

    init(factory: AbstractComponentFactory) {
        self.carouselView = factory.makeCarouselView()
        self.bentoBoxView = factory.makeBentoBoxView(type: .medium)
    }

    func display() {
        carouselView.startCarousel()
        print("BentoBox type: \(bentoBoxView.type)")
    }
}
```

## Example

```swift
let iPhoneComponentFactory = IPhoneComponentFactory()
let iPhoneProductView = ProductView(factory: iPhoneComponentFactory)
iPhoneProductView.display()
// Output:
// iPhone carousel started
// BentoBox type: medium

let iPadComponentFactory = IPadComponentFactory()
let iPadProductView = ProductView(factory: iPadComponentFactory)
iPadProductView.display()
// Output:
// iPad carousel started
// BentoBox type: medium
```
