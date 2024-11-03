<br />

# Memento

> Without violating encapsulation, capture and externalize an object's internal state so that the object can be restored to this state later.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

## Problem statement

## Domain application

Memento:

- Stores internal state of the Originator object. 
- The memento may store as much or as little of the originator's internal state as necessary at its originator's discretion.
- Protects against access by objects other than the originator. 
- Mementos have effectively two interfaces. 
- Caretaker sees a narrow interface to the Memento — it can only pass the memento to other objects.
- Originator, in contrast, sees a wide interface, one that lets it access all the data necessary to restore itself to its previous state.
- Ideally, only the originator that produced the memento would be permitted to access the memento's internal state.

```swift

```

Originator:

- Creates a memento containing a snapshot of its current internal state.
- Uses the memento to restore its internal state.

```swift

```

Caretaker:

- Is responsible for the memento's safekeeping.
- Never operates on or examines the contents of a memento.

```swift

```
