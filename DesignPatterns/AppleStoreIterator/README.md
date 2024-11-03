<br />

# Iterator

> Provide a way to access the elements of an aggregate object sequentially without exposing its underlying representation.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

## Problem statement

## Domain application

Iterator:

Defines an interface for accessing and traversing elements.

```swift

```

Concretelterator:

- Implements the Iterator interface.
- Keeps track of the current position in the traversal of the aggregate.

```swift

```

Aggregate:

Defines an interface for creating an Iterator object.

```swift

```

ConcreteAggregate:

Implements the Iterator creation interface to return an instance of the proper Concretelterator.

```swift

```