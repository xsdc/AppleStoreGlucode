![State](https://github.com/user-attachments/assets/ba018cdd-d8e8-43b9-a0d5-81ccd5c04f52)

<br />

# State

> Allow an object to alter its behaviour when its internal state changes. The object will appear to change its class.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The State pattern lets an object change its behaviour when its internal state changes.

- It encapsulates state-specific behaviour into separate objects and delegates behaviour to the current state.
 
- This avoids large conditional statements and promotes cleaner, more modular code.

- In the Apple Store, we can apply the State pattern to the **product demo video player**, which behaves differently depending on whether a video is **playing**, **paused**, or **stopped**.

## Problem statement

- The Apple Store app allows users to watch demo videos for featured products such as the latest iPhone or MacBook.
 
- The video player can be in one of three states: **Playing**, **Paused**, or **Stopped**.

- The user interface should respond appropriately when a user taps the play or pause button, depending on the current state.

- Without the State pattern, this logic would be scattered across conditional statements, making the player difficult to maintain and extend.

- Using the State pattern, each state encapsulates its own behaviour, and the player simply delegates to the current state.

## Domain application


#### Context:

Holds a reference to a state object that defines the current behaviour of the video player.

```swift
class ProductVideoPlayer {
    private var state: PlayerState

    init(state: PlayerState = StoppedState()) {
        self.state = state
    }

    func setState(_ state: PlayerState) {
        self.state = state
    }

    func play() {
        state.play(context: self)
    }

    func pause() {
        state.pause(context: self)
    }

    func stop() {
        state.stop(context: self)
    }
}
```

#### State Interface:

Defines a common interface for all concrete states.

```swift
protocol PlayerState {
    func play(context: ProductVideoPlayer)
    func pause(context: ProductVideoPlayer)
    func stop(context: ProductVideoPlayer)
}
```

#### Concrete States:

Each concrete state implements behaviour specific to that state.

```swift
class PlayingState: PlayerState {
    func play(context: ProductVideoPlayer) {
        print("Already playing.")
    }

    func pause(context: ProductVideoPlayer) {
        print("Pausing product video.")
        context.setState(PausedState())
    }

    func stop(context: ProductVideoPlayer) {
        print("Stopping product video.")
        context.setState(StoppedState())
    }
}

class PausedState: PlayerState {
    func play(context: ProductVideoPlayer) {
        print("Resuming product video.")
        context.setState(PlayingState())
    }

    func pause(context: ProductVideoPlayer) {
        print("Video is already paused.")
    }

    func stop(context: ProductVideoPlayer) {
        print("Stopping product video.")
        context.setState(StoppedState())
    }
}

class StoppedState: PlayerState {
    func play(context: ProductVideoPlayer) {
        print("Starting product video.")
        context.setState(PlayingState())
    }

    func pause(context: ProductVideoPlayer) {
        print("Cannot pause. Video is stopped.")
    }

    func stop(context: ProductVideoPlayer) {
        print("Video is already stopped.")
    }
}
```

#### Client:

Simulates user interaction with the Apple Store’s video player.

```swift
let player = ProductVideoPlayer()

player.play()   // Starting product video.
player.pause()  // Pausing product video.
player.play()   // Resuming product video.
player.stop()   // Stopping product video.
```