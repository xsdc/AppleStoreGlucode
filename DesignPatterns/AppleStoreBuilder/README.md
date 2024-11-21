![Builder](https://github.com/user-attachments/assets/3a8d3e5b-ab59-4985-9d08-e1534747ad52)

<br />

# Builder

> Separate the construction of a complex object from its representation so that the same construction process can create different representations.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Builder pattern is used to construct objects piece by piece.

- Each part of the object is configured via builder methods.

- We are able to provide different representations of the object using the same construction process.

## Problem statement

- The Apple Store has a feature called the Apple Watch Studio, which allows customers to choose the size, material, and band for their Apple Watch.

- There are different collections of Apple Watches, such as Series 10 and Hèrmes Series 10.

- In the future, collections may be added or removed, and new sizes, materials, and bands may be introduced.

- No matter which collection and options are chosen, the API where we submit configured Apple Watches remains the same.

- To avoid the problem of steering away from this requirement, we can use the Builder pattern, which allows for flexibility in the construction process, while still maintaining a consistent output.

## Definitions

#### Product:

The object that is being constructed.

```swift
struct AppleWatch {
    var collection: String
    var size: String
    var material: String
    var band: String
}
```

#### Builder:

- The protocol that declares the options for constructing the product.

- Associated types are used here so that each concrete builder can define its own enum types for size, material, and band.

- Compare the `AppleWatchSeries10` and `AppleWatchHèrmesSeries10` builder enum types to see this in action.

- The protocol makes use of a fluent interface, allowing for chaining of builder methods.

```swift
protocol AppleWatchBuilder {
    var appleWatch: AppleWatch { get }

    associatedtype SizeType
    associatedtype MaterialType
    associatedtype BandType

    func setSize(_ size: SizeType) -> Self
    func setMaterial(_ material: MaterialType) -> Self
    func setBand(_ band: BandType) -> Self
}
```

#### Concrete builders:

- Conforms to the builder protocol and provides an implementation for building the product.

- Two concrete builders are defined here: `AppleWatchSeries10` and `AppleWatchHèrmesSeries10`.

- Type aliases are used here to pair the associated types for each concrete builder's enum type implementation.

```swift
class AppleWatchSeries10: AppleWatchBuilder {
    var appleWatch = AppleWatch(collection: "Series 10", size: Size.fortyTwo.rawValue, material: Material.aluminum.rawValue, band: Band.sportBand.rawValue)

    enum Size: String {
        case fortyTwo = "42mm"
        case fortySix = "46mm"
    }

    enum Material: String {
        case aluminum = "Aluminum"
        case titanium = "Titanium"
    }

    enum Band: String {
        case sportBand = "Sport Band"
        case milaneseLoop = "Milanese Loop"
    }

    typealias SizeType = Size
    typealias MaterialType = Material
    typealias BandType = Band

    func setSize(_ size: Size) -> Self {
        appleWatch.size = size.rawValue
        return self
    }

    func setMaterial(_ material: Material) -> Self {
        appleWatch.material = material.rawValue
        return self
    }

    func setBand(_ band: Band) -> Self {
        appleWatch.band = band.rawValue
        return self
    }
}

class AppleWatchHèrmesSeries10: AppleWatchBuilder {
    var appleWatch = AppleWatch(collection: "Hèrmes Series 10", size: Size.fortyTwo.rawValue, material: Material.titanium.rawValue, band: Band.torsade.rawValue)

    enum Size: String {
        case fortyTwo = "42mm"
        case fortySix = "46mm"
    }

    enum Material: String {
        case titanium = "Titanium"
    }

    enum Band: String {
        case torsade = "Torsade Single Tour"
        case grand = "Grand H"
    }

    typealias SizeType = Size
    typealias MaterialType = Material
    typealias BandType = Band

    func setSize(_ size: Size) -> Self {
        appleWatch.size = size.rawValue
        return self
    }

    func setMaterial(_ material: Material) -> Self {
        appleWatch.material = material.rawValue
        return self
    }

    func setBand(_ band: Band) -> Self {
        appleWatch.band = band.rawValue
        return self
    }
}
```

#### Director:

- Maintains references to the builder objects.

- Can be used to construct predefined product variations.

```swift
class AppleWatchStudio {
    lazy var series10: AppleWatchSeries10 = {
        let builder = AppleWatchSeries10()
        return builder
    }()

    lazy var hermesSeries10: AppleWatchHèrmesSeries10 = {
        let builder = AppleWatchHèrmesSeries10()
        return builder
    }()
}
```

## Example

```swift
let appleWatchStudio = AppleWatchStudio()

print(appleWatchStudio.series10.appleWatch) // Default Series 10 Apple Watch
// Output: AppleWatch(collection: "Series 10", size: "42mm", material: "Aluminum", band: "Sport Band")

appleWatchStudio.series10.setSize(.fortySix).setMaterial(.titanium).setBand(.milaneseLoop) // Update Series 10 Apple Watch
print(appleWatchStudio.series10.appleWatch)
// Output: AppleWatch(collection: "Series 10", size: "46mm", material: "Titanium", band: "Milanese Loop")

print(appleWatchStudio.hermesSeries10.appleWatch) // Default Hèrmes Series 10 Apple Watch
// Output: AppleWatch(collection: "Hèrmes Series 10", size: "42mm", material: "Titanium", band: "Torsade Single Tour")

appleWatchStudio.hermesSeries10.setSize(.fortySix).setMaterial(.titanium).setBand(.grand) // Update Hèrmes Series 10 Apple Watch
print(appleWatchStudio.hermesSeries10.appleWatch)
// Output: AppleWatch(collection: "Hèrmes Series 10", size: "46mm", material: "Titanium", band: "Grand H")
```
