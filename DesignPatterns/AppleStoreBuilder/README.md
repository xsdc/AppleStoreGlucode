![Builder](https://github.com/user-attachments/assets/3a8d3e5b-ab59-4985-9d08-e1534747ad52)

<br />

# Builder

> Separate the construction of a complex object from its representation so that the same construction process can create different representations.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Builder pattern is used to construct objects piece by piece.

- Each part of the object is configured via a method on a builder object.

- We are able to provide different representations of the object using the same construction process.

## Problem statement

- The Apple Store has a feature called the Apple Watch Studio, which allows customers to choose the size, material, and band for their Apple Watch.

- There are different collections of Apple Watches, such as Series 10 and Hèrmes Series 10.

- In the future, collections may be added or removed, and new sizes, materials, and bands may be introduced.

- No matter which collection and options are chosen, the API where we submit configured Apple Watches remains the same.

- We are faced with the challenges of constructing Apple Watches with various configurations and maintaining a consistent output.

- The Builder pattern gives us the needed flexibility in the construction process and allows us to conform to the requirements of the API.

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

- Compare the `Series10Builder` and `HermesSeries10Builder` enum types to see this in action.

- The protocol makes use of a fluent interface, allowing for the chaining of builder methods.

```swift
protocol AppleWatchBuilder {
    associatedtype SizeType
    associatedtype MaterialType
    associatedtype BandType

    func setSize(_ size: SizeType) -> Self
    func setMaterial(_ material: MaterialType) -> Self
    func setBand(_ band: BandType) -> Self
    func build() -> AppleWatch
}
```

#### Concrete builders:

- Conforms to the builder protocol and provides an implementation for building the product.

- Two concrete builders are defined here: `Series10Builder` and `HermesSeries10Builder`.

- Each one is tailored to a specific collection of Apple Watch.

- Type aliases are used here to pair the associated types for each concrete builder's enum type implementation.

```swift
class Series10Builder: AppleWatchBuilder {
    private var appleWatch = AppleWatch(
        collection: "Series 10",
        size: Size.fortyTwo.rawValue,
        material: Material.aluminum.rawValue,
        band: Band.sportBand.rawValue
    )

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

    @discardableResult
    func setSize(_ size: Size) -> Self {
        appleWatch.size = size.rawValue
        return self
    }

    @discardableResult
    func setMaterial(_ material: Material) -> Self {
        appleWatch.material = material.rawValue
        return self
    }

    @discardableResult
    func setBand(_ band: Band) -> Self {
        appleWatch.band = band.rawValue
        return self
    }

    func build() -> AppleWatch {
        return appleWatch
    }
}

class HermesSeries10Builder: AppleWatchBuilder {
    private var appleWatch = AppleWatch(
        collection: "Hèrmes Series 10",
        size: Size.fortyTwo.rawValue,
        material: Material.titanium.rawValue,
        band: Band.torsade.rawValue
    )

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

    @discardableResult
    func setSize(_ size: Size) -> Self {
        appleWatch.size = size.rawValue
        return self
    }

    @discardableResult
    func setMaterial(_ material: Material) -> Self {
        appleWatch.material = material.rawValue
        return self
    }

    @discardableResult
    func setBand(_ band: Band) -> Self {
        appleWatch.band = band.rawValue
        return self
    }

    func build() -> AppleWatch {
        return appleWatch
    }
}
```

## Example

```swift
let series10Builder = Series10Builder()

print(series10Builder.build()) // Default Series 10 Apple Watch
// Output: AppleWatch(collection: "Series 10", size: "42mm", material: "Aluminum", band: "Sport Band")

series10Builder.setSize(.fortySix).setMaterial(.titanium).setBand(.milaneseLoop) // Update Series 10 Apple Watch
print(series10Builder.build())
// Output: AppleWatch(collection: "Series 10", size: "46mm", material: "Titanium", band: "Milanese Loop")

let hermesSeries10Builder = HermesSeries10Builder()

print(hermesSeries10Builder.build()) // Default Hèrmes Series 10 Apple Watch
// Output: AppleWatch(collection: "Hèrmes Series 10", size: "42mm", material: "Titanium", band: "Torsade Single Tour")

hermesSeries10Builder.setSize(.fortySix).setMaterial(.titanium).setBand(.grand) // Update Hèrmes Series 10 Apple Watch
print(hermesSeries10Builder.build())
// Output: AppleWatch(collection: "Hèrmes Series 10", size: "46mm", material: "Titanium", band: "Grand H")
```
