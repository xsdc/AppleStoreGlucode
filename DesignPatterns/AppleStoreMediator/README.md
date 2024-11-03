<br />

# Mediator

> Define an object that encapsulates how a set of objects interact. Mediator promotes loose coupling by keeping objects from referring to each other explicitly, and it lets you vary their interaction independently.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

## Problem overview

## Domain application

Mediator:

Defines an interface for communicating with Colleague objects.

```swift

```

ConcreteMediator:

- Implements cooperative behavior by coordinating Colleague objects.
- Knows and maintains its colleagues.

```swift

```

Colleague classes:

- Each Colleague class knows its Mediator object.
- Each colleague communicates with its mediator whenever it would have otherwise communicated with another colleague.

```swift

```
