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
    private let images: [String]
    private(set) var currentIndex: Int

    init(images: [String]) {
        self.currentIndex = 0
        self.images = images
    }

    func navigateToNextItem() {
        currentIndex = (currentIndex + 1) % images.count
    }

    func navigateToPreviousItem() {
        currentIndex = (currentIndex - 1) % images.count
    }

    func navigateToItem(at index: Int) {
        currentIndex = index
    }
}
```

#### Command:

- This is a protocol that defines a single method `execute`.

- It will be implemented by concrete commands that map to the receiver.

```swift
protocol CommandExecutor {
    func execute()
}
```

#### Concrete commands:

- Maps the commands to the receiver: `CarouselViewModel`.

- These commands will be used by the various invokers to interact with the view model.

```swift
struct NavigateToNextItemCommand: CommandExecutor {
    let receiver: CarouselViewModel

    func execute() {
        receiver.navigateToNextItem()
    }
}

struct NavigateToPreviousItemCommand: CommandExecutor {
    let receiver: CarouselViewModel

    func execute() {
        receiver.navigateToPreviousItem()
    }
}

struct NavigateToItemCommand: CommandExecutor {
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
    let navigateToNextCommand: CommandExecutor
    let navigateToPreviousCommand: CommandExecutor
    let navigateToItemCommand: CommandExecutor

    func nextButtonTapped() {
        navigateToNextCommand.execute()
    }

    func previousButtonTapped() {
        navigateToPreviousCommand.execute()
    }

    func specificIndexTapped(index: Int) {
        navigateToItemCommand.execute()
    }
}

struct KeyboardInvoker {
    let navigateToNextCommand: CommandExecutor
    let navigateToPreviousCommand: CommandExecutor

    func keyPressedNext() {
        navigateToNextCommand?.execute()
    }

    func keyPressedPrevious() {
        navigateToPreviousCommand?.execute()
    }
}

class TimerInvoker {
    var navigateToNextCommand: CommandExecutor?

    private var dispatchTimer: DispatchSourceTimer?

    func startTimer(interval: TimeInterval) {
        let queue = DispatchQueue.main
        dispatchTimer = DispatchSource.makeTimerSource(queue: queue)
        dispatchTimer?.schedule(deadline: .now() + interval, repeating: interval)
        dispatchTimer?.setEventHandler { [weak self] in
            self?.navigateToNextCommand?.execute()

            if let command = self?.navigateToNextCommand as? NavigateToNextItemCommand {
                print("Carousel index updated via timer: " + "\(command.receiver.currentIndex)")
            }
        }
        dispatchTimer?.resume()
    }
}
```

#### Client:

- The client is responsible for creating the invokers and commands and setting up the interactions.

- For simplicity, we'll simulate button taps, keyboard presses, and timer events.

- Structure of the implementation of the pattern: Invokers (Interaction methods) -> Commands (Carousel actions) -> Receiver (View model)

```swift
class CarouselView {
    private let carouselViewModel: CarouselViewModel

    init(carouselViewModel: CarouselViewModel) {
        self.carouselViewModel = carouselViewModel

        self.tapInvoker = TapInvoker()
        self.tapInvoker.navigateToNextCommand = NavigateToNextItemCommand(receiver: carouselViewModel)
        self.tapInvoker.navigateToPreviousCommand = NavigateToPreviousItemCommand(receiver: carouselViewModel)
        self.tapInvoker.navigateToItemCommand = NavigateToNextItemCommand(receiver: carouselViewModel)

        self.keyboardInvoker = KeyboardInvoker()
        self.keyboardInvoker.navigateToNextCommand = NavigateToNextItemCommand(receiver: carouselViewModel)
        self.keyboardInvoker.navigateToPreviousCommand = NavigateToPreviousItemCommand(receiver: carouselViewModel)

        self.timerInvoker = TimerInvoker()
        self.timerInvoker.navigateToNextCommand = NavigateToNextItemCommand(receiver: carouselViewModel)

        print("Carousel starting index: " + "\(viewModel.currentIndex)")
    }

    private let tapInvoker: TapInvoker
    private let keyboardInvoker: KeyboardInvoker
    private let timerInvoker: TimerInvoker

    // Simulate button taps

    func simulateTapForNextButton() {
        tapInvoker.nextButtonTapped()
        print("Carousel index: " + "\(viewModel.currentIndex)")
    }

    func simulateTapForPreviousButton() {
        tapInvoker.previousButtonTapped()
        print("Carousel index: " + "\(viewModel.currentIndex)")
    }

    func simulateTapOnSpecificIndex(index: Int) {
        tapInvoker.specificIndexTapped(index: index)
        print("Carousel index: " + "\(viewModel.currentIndex)")
    }

    // Simulate keyboard presses

    func simulateRightArrowKeyPress() {
        keyboardInvoker.keyPressedNext()
        print("Carousel index: " + "\(viewModel.currentIndex)")
    }

    func simulateLeftArrowKeyPress() {
        keyboardInvoker.keyPressedPrevious()
        print("Carousel index: " + "\(viewModel.currentIndex)")
    }

    // Simulate timer

    func simulateTimerStart() {
        timerInvoker.startTimer(interval: 5.0)
    }
}
```

## Example

```swift
let viewModel = CarouselViewModel(images: ["image1", "image2", "image3", "image4"])
let view = CarouselView(carouselViewModel: viewModel)

// Tap invoker
view.simulateTapForNextButton()  // Increment by 1
view.simulateTapForPreviousButton() // Decrement by 1
view.simulateTapOnSpecificIndex(index: 1) // Set to index 1

// Keyboard invoker
view.simulateRightArrowKeyPress() // Increment by 1
view.simulateLeftArrowKeyPress() // Decrement by 1

// Output:
// Carousel starting index: 0
// Carousel index: 1
// Carousel index: 0
// Carousel index: 1
// Carousel index: 2
// Carousel index: 1

// Timer invoker
view.simulateTimerStart()

// Output:
// Carousel index updated via timer: 2
// Carousel index updated via timer: 3
// Carousel index updated via timer: 0
// Carousel index updated via timer: 1
// Carousel index updated via timer: 2
// Carousel index updated via timer: 3
// Carousel index updated via timer: 0
// ...
```
