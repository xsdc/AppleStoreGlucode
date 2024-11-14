![Singleton](https://github.com/user-attachments/assets/59d54169-db50-4489-8daf-136f5d7c4e9c)

<br />

# Singleton

> Ensure a class only has one instance, and provide a global point of access to it.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Singleton pattern ensures that only one instance of a particular class is ever created.

- This can be leveraged to provide efficient resource management.

## Problem statement

- Across the Apple Store, we would like access to a user's information for various purposes.

- These include greeting the user, displaying their details, or showing their profile picture.

- Our team has decided to avoid passing the user's information across the app.

- We can use the Singleton pattern to solve this problem.

- This allows us to conveniently access and update it.

## Definitions

#### Singleton:

Responsbile for creating and managing the single instance of a class.

```swift
class UserInformation {
    static let shared = UserInformation()

    private init() {}

    var name: String = "Tim"

    func getGreeting() -> String {
        return "Hello, \(name)"
    }
}
```

## Example

```swift
let userInformation = UserInformation.shared
print(userInformation.getGreeting()) // Hello, Tim
```
