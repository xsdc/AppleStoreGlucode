<br />

# Prototype

> Specify the kinds of objects to create using a prototypical instance, and create new objects by copying this prototype.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Prototype pattern allows an object to create a copy of itself.
- The pattern is used when creating an instance of a class is more expensive than copying an existing instance.

## Problem statement

- Consider the scenario where we would like to hold a reference to a saved Apple Watch Studio configuration.
- This could later be restored, and be used to create a new configuration with the same properties.
- The Prototype pattern is aimed at formalizing this process using an interface.

## Domain application

Prototype:

Declares an interface for cloning itself.

```swift
protocol Clonable {
    func clone() -> Clonable
}
```

ConcretePrototype:

Implements an operation for cloning itself.

```swift
class AppleWatchStudioConfiguration: Clonable {
    var caseMaterial: String
    var bandMaterial: String
    var caseSize: Int
    var bandSize: Int

    init(caseMaterial: String, bandMaterial: String, caseSize: Int, bandSize: Int) {
        self.caseMaterial = caseMaterial
        self.bandMaterial = bandMaterial
        self.caseSize = caseSize
        self.bandSize = bandSize
    }

    func clone() -> Clonable {
        return AppleWatchConfiguration(caseMaterial: caseMaterial, bandMaterial: bandMaterial, caseSize: caseSize, bandSize: bandSize)
    }
}
```

Client:

Creates a new object by asking a prototype to clone itself.

```swift
class AppleWatchStudio {
    var configuration: Clonable

    init(configuration: Clonable) {
        self.configuration = configuration
    }

    func createNewConfiguration() -> Clonable {
        return configuration.clone()
    }
}
```
