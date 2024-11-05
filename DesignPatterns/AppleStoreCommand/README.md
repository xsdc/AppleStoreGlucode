![Command](https://github.com/user-attachments/assets/4ad618c7-cebb-45e4-8d2c-bbacfc882717)

<br />

# Command

> Encapsulate a request as an object, thereby letting you parameterize clients with different requests, queue or log requests, and support undoable operations.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Command design pattern is useful when you want to decouple an action from the object that invokes the action.
- This decoupling allows for more flexibility in how actions are triggered.
- For example, buttons are typically used to trigger actions in a user interface. However, keybindings, menu items, and other objects can also trigger actions.
- Decoupling the action from the object that invokes the action allows for more flexibility in how actions are triggered.

## Problem statement

- On Apple Store product pages, there are often carousels that allow users to scroll through images of the product.
- These carousels typically have buttons that allow users to navigate to the next or previous image.
- Navigation is also possible by swiping left or right on the image itself, and using the arrow keys on a keyboard.
- We'll use the Command design pattern to decouple the navigation logic from the objects that trigger the navigation.

## Domain application

Command:

Declares an interface for executing an operation.

```swift
protocol ImageCommand {
    func execute()
}
```

ConcreteCommand:

- Defines a binding between a Receiver object and an action.
- Implements Execute by invoking the corresponding operation(s) on Receiver.

```swift
class NextImageCommand: ImageCommand {
    let receiver: ImageCarousel

    func execute() {
        receiver.nextImage()
    }
}
```

Client:

Creates a ConcreteCommand object and sets its receiver.

```swift
class ImageCarousel {
    var images: [String]
    var currentIndex: Int

    func nextImage() {
        currentIndex = (currentIndex + 1) % images.count
    }
}
```

Invoker:

Asks the command to carry out the request.

```swift
class Navigation {
    var command: Command

    func navigate() {
        command.execute()
    }
}
```

Receiver:

- Knows how to perform the operations associated with carrying out a request.
- Any class may serve as a Receiver.

```swift
class ImageReceiver {
    var images: [String]
    var currentIndex: Int

    func nextImage() {
        currentIndex = (currentIndex + 1) % images.count
    }
}
```
