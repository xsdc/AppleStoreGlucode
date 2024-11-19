![Prototype](https://github.com/user-attachments/assets/e7e2eb82-d7ee-4e65-9c9b-5289e5fabf03)

<br />

# Prototype

> Specify the kinds of objects to create using a prototypical instance, and create new objects by copying this prototype.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Prototype pattern allows an object to create a copy of itself.

- This is typically used when the recreation of an object is costly or complex.

- It may also be used to create variations of an object without the need to subclass it.

## Problem statement

- When configuring a product on the Apple Store, there are often multiple options to choose from.

- Let's assume there is a currency selector that allows us to quickly switch between different currencies.

- We would like to update the product configuration based on the selected currency, and avoid having to fetch the product configuration from the server each time.

- The Prototype pattern can be used to create a copy of the product configuration options with the updated currency.

## Definitions

#### Prototype:

- Declares the protocol that provides a method for cloning concrete implementations.

- Typically, this protocol will have a single method called `clone()`.

- In our case, we have included a parameter to demonstrate the concept of cloning with a currency conversion rate.

```swift
protocol CloneableProductConfiguration {
    func cloneWithConversionRate(of conversionRate: Double) -> Self
}
```

#### ConcretePrototype:

- Implements an operation for cloning itself.

- The price conversion method is kept simple for demonstration purposes.

```swift
struct ConfigurationOption {
    let name: String
    let price: Double
}

struct iPhoneProductConfiguration: CloneableProductConfiguration {
    func cloneWithConversionRate(of conversionRate: Double) -> iPhoneProductConfiguration {
        let storageOptions = self.storageOptions.map { option in
            ConfigurationOption(name: option.name, price: option.price * conversionRate)
        }

        return iPhoneProductConfiguration(storageOptions: storageOptions)
    }

    let storageOptions: [ConfigurationOption]
}
```

## Example

```swift
let configurationOptions = [
    ConfigurationOption(name: "64GB", price: 700),
    ConfigurationOption(name: "128GB", price: 800),
    ConfigurationOption(name: "256GB", price: 900)
]

let dollarConfiguration = iPhoneProductConfiguration(storageOptions: configurationOptions)

// Clone the configuration with a conversion rate of 0.9
let euroConfiguration = dollarConfiguration.cloneWithConversionRate(of: 0.9)

for option in euroConfiguration.storageOptions {
    print("Storage: \(option.name), Price: \(option.price)")
}

// Output:
// Storage: 64GB, Price: 630.0
// Storage: 128GB, Price: 720.0
// Storage: 256GB, Price: 810.0
```
