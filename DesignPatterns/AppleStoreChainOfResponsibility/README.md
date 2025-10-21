![ChainOfResponsibility](https://github.com/user-attachments/assets/a7150b35-2cc1-4095-9fe3-2b9b9f4aea74)

<br />

# Chain of Responsibility

> Avoid coupling the sender of a request to its receiver by giving more than one object a chance to handle the request. Chain the receiving objects and pass the request along the chain until an object handles it.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Chain of Responsibility pattern provides a way of linking a series of actions.

- Each action has a task to perform, and once it's completed, the request is optionally passed to the next action in the chain.

- This pattern allows for a clear separation of concerns and flexibility in the order of actions.

## Problem statement

- When users add a product to their bag, a series of actions need to be performed.

- For example, checking if the product is in stock, attempting to add it to the bag, and logging an analytics event.

- Handling all of these actions in a single class is possible, but can lead to coupling and a lack of flexibility.

- The Chain of Responsibility pattern can be used to create a chain of handlers, each responsible for a specific action.

- Each handler performs its specific action and then optionally passes the request to the next handler in the chain.

- This enables a clear separation of concerns and allows for flexibility to add, remove, or reorder the handlers in the chain.

## Definitions

### Handler:

- Defines the interface for handling requests and setting up the chain.

- Handlers perform their action (e.g., print) and optionally forward the request to `next`.

- The `Request` object can be used at any point in the chain.

- The `next` property is used to maintain a reference to the next handler in the chain.

```swift
protocol Handler {
    var next: Handler? { get }
    func handle(request: Request)
}

struct Request {
    let productId: String
}
```

### Concrete handlers:

- Handles requests it is responsible for.

- Maintains a reference to the next handler in the chain.

- In this chain, before adding the product to the bag, the stock check handler checks if the product is in stock.

- If it's in stock, then the `AddToBagHandler` is called.

- Assuming it gets added to the bag, the logging handler is called, completing the chain.

- This approach allows for flexibility in the order of the handlers while keeping a clear separation of concerns.

```swift
struct StockCheckHandler: Handler {
    let next: Handler?

    func handle(request: Request) {
        let isInStock = Bool.random()

        if isInStock {
            print("Product \(request.productId) is in stock")
            next?.handle(request: request)
        } else {
            print("Product \(request.productId) is out of stock")
        }
    }
}

struct AddToBagHandler: Handler {
    let next: Handler?

    func handle(request: Request) {
        let addToBagSucceeded = Bool.random()

        if addToBagSucceeded {
            print("Product \(request.productId) added to bag")
            next?.handle(request: request)
        } else {
            print("Failed to add product \(request.productId) to bag")
        }
    }
}

struct LoggingHandler: Handler {
    let next: Handler?

    func handle(request: Request) {
        print("Analytics event logged for product \(request.productId)")
    }
}
```

## Example

```swift
let loggingHandler = LoggingHandler(next: nil)
let addToBagHandler = AddToBagHandler(next: loggingHandler)
let stockCheckHandler = StockCheckHandler(next: addToBagHandler)

let request = Request(productId: "1234")
stockCheckHandler.handle(request: request)

// Output:
// Product 1234 is in stock
// Product 1234 added to bag
// Analytics event logged for product 1234
```
