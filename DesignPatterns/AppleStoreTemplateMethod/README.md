![TemplateMethod](https://github.com/user-attachments/assets/54b05943-1687-4761-8f07-5f51f6206aae)

<br />

# Template Method

> Define the skeleton of an algorithm in an operation, deferring some steps to subclasses. Template Method lets subclasses redefine certain steps of an algorithm without changing the algorithm's structure.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Template Method pattern starts with defining a protocol listing steps in a sequence of operations we would like to perform.

- We then provide a default implementation for each step in the sequence, as well as define the method that orchestrates the sequence.

- Subclasses are then created to override the default implementation as needed.

## Problem statement

- Apple Store customers are able to configure their Apple Watch using the Apple Watch Studio.

- Let's assume the configuration is stored in memory in a way that is convenient for the frontend to display, but not in the expected format needed to send to the backend.

- Each watch series also has a different data structure we need to convert from.

- We'll use the Template Method pattern to define the steps needed to convert the configuration to the expected format.

- The pattern will allow us to cater to different watch series by providing a custom implementation for each series.

- Each series would have its own implementation of the steps needed to convert the configuration to the expected format.

## Definitions

#### Abstract class:

- Defines the steps in the sequence needed to map the configuration to the expected format.

- Provides a default implementation for each step in the sequence.

- Defines the default implementation of `process`, which orchestrates the sequence.

- We provide a default implementation of the `AppleWatchConfiguration` called `DefaultAppleWatchConfiguration`, which marks the `process()` method as `final` to protect the process defined.

```swift
protocol AppleWatchConfiguration {
    func process()
    func mapDataForWatchCaseSize()
    func mapDataForWatchCaseMaterial()
    func mapDataForWatchBand()
    func mapDataForWatchBandSize()
    func mapDataForWatchEngraving()
}

class DefaultAppleWatchConfiguration: AppleWatchConfiguration {
    final func process() {
        mapDataForWatchCaseSize()
        mapDataForWatchCaseMaterial()
        mapDataForWatchBand()
        mapDataForWatchBandSize()
        mapDataForWatchEngraving()
    }

    func mapDataForWatchCaseSize() {
        print("Default implementation for case size.")
    }
    
    func mapDataForWatchCaseMaterial() {
        print("Default implementation for case material.")
    }
    
    func mapDataForWatchBand() {
        print("Default implementation for watch band.")
    }
    
    func mapDataForWatchBandSize() {
        print("Default implementation for band size.")
    }
    
    func mapDataForWatchEngraving() {
        print("Default implementation for engraving.")
    }
}
```

#### Concrete classes:

- Provides the custom configuration for each series.

- The Hermès Series 10 Apple Watch has a different configuration format than the Series 10 Apple Watch.

- The Hermès series only offers the titanium case material, which is why we can set it manually in the `mapDataForWatchCaseMaterial` method.

- The Hermès series does not offer the engraving option, so we can skip the `mapDataForWatchEngraving` method.

- For simplicity, the data mapping implementations are omitted.

```swift
class Series10AppleWatchConfiguration: DefaultAppleWatchConfiguration {
    override func mapDataForWatchCaseSize() {
        print("Implementation for converting the data structure for the Apple Watch Series 10 case size.")
    }

    override func mapDataForWatchCaseMaterial() {
        print("Implementation for converting the data structure for the Apple Watch Series 10 case material.")
    }

    override func mapDataForWatchBand() {
        print("Implementation for converting the data structure for the Apple Watch Series 10 band.")
    }

    override func mapDataForWatchBandSize() {
        print("Implementation for converting the data structure for the Apple Watch Series 10 band size.")
    }

    override func mapDataForWatchEngraving() {
        print("Implementation for converting the data structure for the Apple Watch Series 10 engraving.")
    }
}

class HermèsSeries10AppleWatchConfiguration: DefaultAppleWatchConfiguration {
    override func mapDataForWatchCaseSize() {
        print("Implementation for converting the data structure for the Apple Watch Hermès Series case size.")
    }

    override func mapDataForWatchCaseMaterial() {
        print("Implementation for converting the data structure for the Apple Watch Hermès Series case material.")
    }

    override func mapDataForWatchBand() {
        print("Implementation for converting the data structure for the Apple Watch Hermès Series band.")
    }

    override func mapDataForWatchBandSize() {
        print("Implementation for converting the data structure for the Apple Watch Hermès Series band size.")
    }

    override func mapDataForWatchEngraving() {
        print("Implementation for converting the data structure for the Apple Watch Hermès Series 10 engraving.")
    }
}
```

## Example

```swift
let series10AppleWatchConfiguration = Series10AppleWatchConfiguration()
series10AppleWatchConfiguration.process()

// Output:
// Implementation for converting the front data structure for the Apple Watch Series 10 case size.
// Implementation for converting the front data structure for the Apple Watch Series 10 case material.
// Implementation for converting the front data structure for the Apple Watch Series 10 band.
// Implementation for converting the front data structure for the Apple Watch Series 10 band size.
// Implementation for converting the front data structure for the Apple Watch Series 10 engraving.

let hermèsSeries10AppleWatchConfiguration = HermèsSeries10AppleWatchConfiguration()
hermèsSeries10AppleWatchConfiguration.process()

// Output:
// Implementation for converting the data structure for the Apple Watch Hermès Series case size.
// Implementation for converting the data structure for the Apple Watch Hermès Series case material.
// Implementation for converting the data structure for the Apple Watch Hermès Series band.
// Implementation for converting the data structure for the Apple Watch Hermès Series band size.
// Implementation for converting the data structure for the Apple Watch Hermès Series 10 engraving.
```
