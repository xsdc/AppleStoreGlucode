![C0](https://github.com/user-attachments/assets/94c603b6-5a38-40d8-9658-9ca46e8db6f4)

## Composite

The Composite Design Pattern is a structural pattern that allows you to create tree-like structures to represent groups of objects. This pattern enables you to treat individual objects and collections of objects uniformly, simplifying your code and enhancing flexibility.

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

> Compose objects into tree structures to represent part-whole hierarchies. Composite lets clients treat individual objects and compositions of objects uniformly. 
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

![C1](https://github.com/user-attachments/assets/1e40f626-06c5-4deb-9ffd-9845a44e7ce5)