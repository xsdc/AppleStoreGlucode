<br />

# Builder

> Separate the construction of a complex object from its representation so that the same construction process can create different representations.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Builder pattern allows for the construction of a complex object step by step.
- The pattern allows for the construction of different representations of the object using the same construction process.
- For example, consider a car. The car can be built with different features, such as the color, the interior, the wheels, and so on.
- The Builder pattern allows for the construction of a car with different features using the same construction process.

## Problem statement

- Before placing an order on the Apple Store, various information comes together to create an order
- Products, product quantities, shipping information, and payment information. The order is created by combining all this information.
- The Builder pattern can be used to create an order by combining all this information.

## Domain application

Builder:

Specifies an abstract interface for creating parts of a Product object.

```swift
protocol OrderBuilder {
    func setProduct(product: Product)
    func setQuantity(quantity: Int)
    func setShippingAddress(address: String)
    func setPaymentMethod(paymentMethod: String)
    func build() -> Order
}
```

ConcreteBuilder:

- Constructs and assembles parts of the product by implementing the Builder interface.
- Defines and keeps track of the representation it creates.
- Provides an interface for retrieving the product.

```swift
struct CheckoutOrderBuilder: OrderBuilder {
    private var order = Order()

    func setProduct(product: Product) {
        order.product = product
    }

    func setQuantity(quantity: Int) {
        order.quantity = quantity
    }

    func setShippingAddress(address: String) {
        order.shippingAddress = address
    }

    func setPaymentMethod(paymentMethod: String) {
        order.paymentMethod = paymentMethod
    }

    func build() -> Order {
        return order
    }
}
```

Director:

Constructs an object using the Builder interface.

```swift
struct OrderDirector {
    let builder: OrderBuilder

    func construct() -> Order {
        builder.setProduct(product: Product(name: "iPhone", price: 999.00))
        builder.setQuantity(quantity: 1)
        builder.setShippingAddress(address: "123 7th Ave, New York, NY 10001")
        builder.setPaymentMethod(paymentMethod: "Credit Card")

        return builder.build()
    }
}
```

Product:

- Represents the complex object under construction.
- ConcreteBuilder builds the product's internal representation and defines the process by which it's assembled.
- Includes classes that define the constituent parts, including interfaces for assembling the parts into the final result.

```swift
struct Order {
    var product: Product?
    var quantity: Int?
    var shippingAddress: String?
    var paymentMethod: String?
}
```
