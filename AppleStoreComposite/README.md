# Composite

<br />

![Composite](https://github.com/user-attachments/assets/dfbd0dbd-1ab2-47b1-8fcf-6d5cb7307234)

<br />

## Theory

> Compose objects into tree structures to represent part-whole hierarchies. Composite lets clients treat individual objects and compositions of objects uniformly. 
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

#### Component: A protocol that represents all objects in the hierarchy

```swift
protocol Component {
    var id: String { get }
    var name: String { get }
}
```

#### Composite: A component that can hold other components

```swift
struct Composite: Component {
    let id: String
    let name: String
    var children: [Component] = []
    
    mutating func addComponent(_ component: Component) {
        children.append(component)
    }

    mutating func removeComponent(_ component: Component) {
        if let index = children.firstIndex(where: { $0.id == component.id }) {
            children.remove(at: index)
        }
    }
}
```

#### Leaf: A component that has no children

```swift
struct Leaf: Component {
    let id: String
    let name: String
    let description: String
}
```

## Application

The Composite Design Pattern is a structural pattern that allows you to create tree-like structures to represent groups of objects. This pattern enables you to treat individual objects and collections of objects uniformly, simplifying your code and enhancing flexibility.
