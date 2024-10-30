<br />

# Chain of Responsibility

> Avoid coupling the sender of a request to its receiver by giving more than one object a chance to handle the request. Chain the receiving objects and pass the request along the chain until an object handles it.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Chain of Responsibility pattern is a behavioral pattern that allows more than one object to handle a request.
- The pattern chains the receiving objects and passes the request along the chain until an object handles it.
- For example, if an app home screen has multiple components, a sequence of service calls may be required to load the screen. These can be chained together using the pattern.
- In addition to being an efficient way to handle a sequence of steps, the pattern allows for each one to be customised according to the requirements.
- The request passed through the chain can be modified by each step in the chain.

## Problem statement

- When adding an item to the bag, we would like to perform an inventory check if it's not a preordered item.
- We would also like to check if the current session is valid.
- The two steps are required to be performed in sequence.

## Domain application

Handler:

- Defines an interface for handling requests.
- Implements the successor link. (Optional)

```swift
public protocol Handler {
    var nextHandler: (any Handler)? { get set }
    func handle(request: Request) async -> Result<Bool, Error>
}
```

ConcreteHandler:

- Handles requests it is responsible for.
- Can access its successor.
- If the ConcreteHandler can handle the request, it does so; otherwise it forwards the request to its successor.

```swift
public class InventoryCheckHandler: Handler {
    public var inventoryService: InventoryService
    public var nextHandler: (any Handler)?

    public init(inventoryService: InventoryService, nextHandler: (any Handler)?) {
        self.inventoryService = inventoryService
        self.nextHandler = nextHandler
    }

    public func handle(request: Request) async -> Result<Bool, Error> {
        if request.isPreorder {
            // No inventory check required for preordered items
            return await nextHandler?.handle(request: request) ?? .success(true)
        }
        else {
            let result = await inventoryService.checkIfProductIsInStock(productId: request.productId)

            switch result {
            case .success:
                return await nextHandler?.handle(request: request) ?? .success(true)
            case .failure(let error):
                return .failure(error)
            }
        }
    }
}
```

```swift
public class AuthenticationHandler: Handler {
    public var authenticationService: AuthenticationService
    public var nextHandler: (any Handler)?

    public init(authenticationService: AuthenticationService, nextHandler: (any Handler)?) {
        self.authenticationService = authenticationService
        self.nextHandler = nextHandler
    }

    public func handle(request: Request) async -> Result<Bool, Error> {
        let result = await authenticationService.checkIfSessionIsValid()

        switch result {
        case .success:
            return await nextHandler?.handle(request: request) ?? .success(true)
        case .failure(let error):
            return .failure(error)
        }
    }
}
```

Client: Initiates the request to a ConcreteHandler object on the chain.

```swift
public struct BagService {
    let handler: Handler

    public init(handler: Handler) {
        self.handler = handler
    }

    public func addProductToBag(productId: String, isPreorder: Bool, isAuthenticated: Bool) async -> Result<Bool, Error> {
        let request = Request(productId: productId, isPreorder: isPreorder, isAuthenticated: isAuthenticated)
        return await handler.handle(request: request)
    }
}
```
