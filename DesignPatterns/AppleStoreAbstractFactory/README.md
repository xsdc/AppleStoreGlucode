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

- Each Apple Store product page contains reoccurring components, such as a bento box and carousel.

- These components may be implemented with layout differences depending on the device the user is using.

- Our objective is to start with a simple system that can create each component for iPhone and iPad.

- When trying to use the same component class for the different devices, we may end up with complex conditional statements.

- To avoid this, the Abstract Factory pattern can be used to create a system that can create specific components for specific devices.

- This is all done without the client knowing the specific classes of the components nor the device.

- The concrete factory and products can be determined at runtime.

## Definitions

#### Abstract products:

- Declare protocols for components we want to create.

- Collectively, these protocols define a group of products that make up a product family.

- We've kept it simple by only including two components: a carousel and a bento box.

```swift
protocol CarouselViewable {
    func stopCarousel()
    func startCarousel()
}

protocol BentoBoxViewable {
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
class iPhoneCarouselView: CarouselViewable {
    func stopCarousel() {
        print("iPhone carousel stopped")
    }

    func startCarousel() {
        print("iPhone carousel started")
    }
}

class iPadCarouselView: CarouselViewable {
    func stopCarousel() {
        print("iPad carousel stopped")
    }

    func startCarousel() {
        print("iPad carousel started")
    }
}

class iPhoneBentoBoxView: BentoBoxViewable {
    let type: BentoBoxType

    init(type: BentoBoxType) {
        self.type = type
    }
}

class iPadBentoBoxView: BentoBoxViewable {
    let type: BentoBoxType

    init(type: BentoBoxType) {
        self.type = type
    }
}
```

#### Abstract factory:

- Declares a protocol for each product family.

- Each protocol declares a set of methods for creating each product.

```swift
protocol AbstractComponentFactory {
    func makeCarouselView() -> CarouselViewable
    func makeBentoBoxView(type: BentoBoxViewable.BentoBoxType) -> BentoBoxViewable
}
```

#### Concrete factory:

Implements the protocol declared by the abstract factory.

```swift
class iPhoneComponentFactory: AbstractComponentFactory {
    func makeCarouselView() -> CarouselViewable {
        return iPhoneCarouselView()
    }

    func makeBentoBoxView(type: BentoBoxViewable.BentoBoxType) -> BentoBoxViewable {
        return iPhoneBentoBoxView(type: type)
    }
}

class iPadComponentFactory: AbstractComponentFactory {
    func makeCarouselView() -> CarouselViewable {
        return iPadCarouselView()
    }

    func makeBentoBoxView(type: BentoBoxViewable.BentoBoxType) -> BentoBoxViewable {
        return iPadBentoBoxView(type: type)
    }
}
```

#### Client:

- The client uses the abstract factory to create products.

- These can be used without knowing the specific classes of the products.

```swift
class ProductView {
    private let carouselView: CarouselViewable
    private let bentoBoxView: BentoBoxViewable

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
let iPhoneComponentFactory = iPhoneComponentFactory()
let iPhoneProductView = ProductView(factory: iPhoneComponentFactory)
iPhoneProductView.display()
// Output:
// iPhone carousel started
// BentoBox type: medium

let iPadComponentFactory = iPadComponentFactory()
let iPadProductView = ProductView(factory: iPadComponentFactory)
iPadProductView.display()
// Output:
// iPad carousel started
// BentoBox type: medium
```
