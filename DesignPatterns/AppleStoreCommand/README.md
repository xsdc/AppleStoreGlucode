![Command](https://github.com/user-attachments/assets/4ad618c7-cebb-45e4-8d2c-bbacfc882717)

<br />

# Command

> Encapsulate a request as an object, thereby letting you parameterize clients with different requests, queue or log requests, and support undoable operations.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Command design pattern involves decoupling the sender and receiver of a request.

- Senders are called invokers, and they are responsible for executing commands.

- Commands interact with a receiver, which is responsible for performing the desired action.

- Structure of the pattern: Invokers -> Commands -> Receiver

## Problem statement

- On Apple Store product pages, there are often carousels that allow users to view multiple images of a product.

- Interaction with the carousel is primarily initiated by the user via buttons.

- In addition to this, there are other ways the carousel can be updated.

- These include keyboard shortcuts, voice commands, and via a timer that periodically moves to the next image.

- We want to avoid the problem of bundling all these modes of interaction into a single class.

- The Command pattern is aimed at encapsulating these modes into separate objects called invokers.

- These invokers then interact with a set of common commands (Next, previous, etc.), that in turn interact with a receiver (Carousel view model).

- This enables a clean separation of concerns and allows for the addition or removal of interaction modes in the future, conforming to the open/closed principle, and the single responsibility principle.

## Definitions

#### Receiver:

- The receiver is the last object in the Commmand pattern chain that performs the desired action.

- This is typically an existing object that we want to decouple from.

- In our case, the receiver is the carousel view model.

```swift
class CarouselViewModel {
    private(set) var imagePaths: [String]
    private(set) var currentIndex: Int = 0

    init(imagePaths: [String]) {
        self.imagePaths = imagePaths
    }

    func navigateToNextItem() {
        currentIndex = (currentIndex + 1) % imagePaths.count
    }

    func navigateToPreviousItem() {
        currentIndex = ((currentIndex - 1) + imagePaths.count) % imagePaths.count
    }

    func navigateToItem(at index: Int) {
        guard index >= 0 && index < imagePaths.count else { return }
        currentIndex = index
    }
}
```

#### Command:

- This is a protocol that defines a single method `execute`.

- It will be implemented by concrete commands that map to the receiver.

```swift
protocol CommandExecuting {
    func execute()
}
```

#### Concrete commands:

- Maps the commands to the receiver: `CarouselViewModel`.

- These commands will be used by the various invokers to interact with the view model.

```swift
struct NavigateToNextItemCommand: CommandExecuting {
    let receiver: CarouselViewModel

    func execute() {
        receiver.navigateToNextItem()
    }
}

struct NavigateToPreviousItemCommand: CommandExecuting {
    let receiver: CarouselViewModel

    func execute() {
        receiver.navigateToPreviousItem()
    }
}

struct NavigateToItemCommand: CommandExecuting {
    let receiver: CarouselViewModel
    let index: Int

    func execute() {
        receiver.navigateToItem(at: index)
    }
}
```

#### Invoker:

- Each mode of interaction will have its own invoker, which will be responsible for executing the commands.

- For our carousel, we'll support three modes of interaction: Button taps, keyboard shortcuts, and a timer.

```swift
struct TapInvoker {
    let receiver: CarouselViewModel

    func rightArrowButtonTapped() {
        let navigateToNextCommand = NavigateToNextItemCommand(receiver: receiver)
        navigateToNextCommand.execute()
    }

    func leftArrowButtonTapped() {
        let navigateToPreviousCommand = NavigateToPreviousItemCommand(receiver: receiver)
        navigateToPreviousCommand.execute()
    }

    func buttonTappedForIndex(_ index: Int) {
        let navigateToItemCommand = NavigateToItemCommand(receiver: receiver, index: index)
        navigateToItemCommand.execute()
    }
}

struct KeyboardInvoker {
    let receiver: CarouselViewModel

    func rightArrowKeyPressed() {
        let navigateToNextCommand = NavigateToNextItemCommand(receiver: receiver)
        navigateToNextCommand.execute()
    }

    func leftArrowKeyPressed() {
        let navigateToPreviousCommand = NavigateToPreviousItemCommand(receiver: receiver)
        navigateToPreviousCommand.execute()
    }
}

struct TimerInvoker {
    let receiver: CarouselViewModel
    private let dispatchTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.main)

    func startTimer(interval: TimeInterval) {
        let navigateToNextCommand = NavigateToNextItemCommand(receiver: receiver)

        dispatchTimer.schedule(deadline: .now() + interval, repeating: interval)
        dispatchTimer.setEventHandler {
            navigateToNextCommand.execute()
        }
        dispatchTimer.resume()
    }
}
```

#### Client:

- The client is responsible for creating the invokers and commands and setting up the interactions.

- For simplicity, we'll simulate button taps, keyboard presses, and timer events.

- Structure of the implementation of the pattern: Invokers (Interaction methods) -> Commands (Carousel actions) -> Receiver (View model)

```swift
class CarouselView {
    let viewModel: CarouselViewModel
    private let keyboardInvoker: KeyboardInvoker
    private let tapInvoker: TapInvoker
    private let timerInvoker: TimerInvoker

    init(viewModel: CarouselViewModel) {
        self.viewModel = viewModel
        self.keyboardInvoker = KeyboardInvoker(receiver: viewModel)
        self.tapInvoker = TapInvoker(receiver: viewModel)
        self.timerInvoker = TimerInvoker(receiver: viewModel)
    }

    // Tap invoker

    func rightArrowButtonTapped() {
        tapInvoker.rightArrowButtonTapped()
    }

    func leftArrowButtonTapped() {
        tapInvoker.leftArrowButtonTapped()
    }

    func buttonTappedForIndex(_ index: Int) {
        tapInvoker.buttonTappedForIndex(index)
    }

    // Keyboard invoker

    func rightArrowKeyPressed() {
        keyboardInvoker.rightArrowKeyPressed()
    }

    func leftArrowKeyPressed() {
        keyboardInvoker.leftArrowKeyPressed()
    }

    // Timer invoker

    func simulateTimerStart() {
        timerInvoker.startTimer(interval: 5.0)
    }
}
```

## Example

```swift
let viewModel = CarouselViewModel(imagePaths: ["image1", "image2", "image3", "image4"])
let view = CarouselView(viewModel: viewModel)

// Tap invoker

view.rightArrowButtonTapped()  // Increment carousel index
view.leftArrowButtonTapped() // Decrement carousel index
view.buttonTappedForIndex(1)// Set carousel index to 1

// Keyboard invoker

view.rightArrowKeyPressed() // Increment carousel index
view.leftArrowKeyPressed() // Decrement carousel index

// Timer invoker

view.simulateTimerStart() // Increments carousel index every 5 seconds
```
