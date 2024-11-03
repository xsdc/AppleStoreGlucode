<br />

# Visitor

> Represent an operation to be performed on the elements of an object structure. Visitor lets you define a new operation without changing the classes of the elements on which it operates.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

## Problem statement

## Domain application

Visitor:

- Declares a Visit operation for each class of ConcreteElement in the object structure.
- The operation's name and signature identifies the class that sends the Visit request to the visitor.
- That lets the visitor determine the concrete class of the element being visited.
- Then the visitor can access the element directly through its particular interface.

```swift

```

Concrete Visitor:

- Implements each operation declared by Visitor.
- Each operation implements a fragment of the algorithm defined for the corresponding class of object in the structure.
- ConcreteVisitor provides the context for the algorithm and stores its local state.
- This state often accumulates results during the traversal of the structure.

```swift

```

Element:

Defines an Accept operation that takes a visitor as an argument.

```swift

```

ConcreteElement:

Implements an Accept operation that takes a visitor as an argument.

```swift

```

ObjectStructure:

- Can enumerate its elements.
- May provide a high-level interface to allow the visitor to visit its elements.
- May either be a composite or a collection such as a list or a set.

```swift

```
