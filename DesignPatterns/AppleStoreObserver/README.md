<br />

# Observer

> Define a one-to-many dependency between objects so that when one object changes state, all its dependents are notified and updated automatically.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

## Problem statement

## Domain application

Subject:

- Knows its observers. Any number of Observer objects may observe a subject.
- Provides an interface for attaching and detaching Observer objects.

```swift

```

Observer:

Defines an updating interface for objects that should be notified of changes in a subject.

```swift

```

ConcreteSubject:

- Stores state of interest to ConcreteObserver objects.
- Sends a notification to its observers when its state changes.

```swift

```

ConcreteObserver:

- Maintains a reference to a ConcreteSubject object.
- Stores state that should stay consistent with the subject's.
- Implements the Observer updating interface to keep its state consistent with the subject's.

```swift

```
