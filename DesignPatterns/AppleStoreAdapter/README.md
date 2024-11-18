![Adapter](https://github.com/user-attachments/assets/1ade6f0e-2ca8-4821-b319-64784de1d353)

<br />

# Adapter

> Convert the interface of a class into another interface clients expect. Adapter lets classes work together that couldn't otherwise because of incompatible interfaces.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Adapter pattern allows related classes with incompatible data structures to be handled in a unified manner.

- It achieves this by converting the differing data structures into a single structure that the client can use.

## Problem statement

- The Apple Store may request data from multiple product recommendation engine APIs.

- Let's assume the data structures returned from these APIs are not compatible with each other.

- To simplify this, we'll use the Adapter pattern to convert the data structures into a unified `Product` structure.

## Definitions

#### Target:

Defines the common structure that the adapters convert to.

```swift
struct Product: Identifiable {
    let id: String
    let name: String
}
```

#### Adaptee:

Defines a protocol that adapters conform to in order to return unified `Product` structures.

```swift
protocol RecommendationEngineAdapter {
    func fetchProductRecommendations() -> [Product]
}
```

#### Adapter:

Conforms to the Adaptee protocol to convert the incompatible data structures to the unified `Product` structure.

```swift
class MachineLearningRecommendationEngineAdapter: RecommendationEngineAdapter {
    private struct MachineLearningServiceProduct {
        let machineLearningId: String
        let machineLearningName: String
    }

    private let machineLearningServiceProducts = [
        MachineLearningServiceProduct(machineLearningId: "1234", machineLearningName: "Apple Watch Ultra"),
        MachineLearningServiceProduct(machineLearningId: "4321", machineLearningName: "Vision Pro")
    ]

    func fetchProductRecommendations() -> [Product] {
        return machineLearningServiceProducts.map { machineLearningProduct in
            Product(id: machineLearningProduct.machineLearningId, name: machineLearningProduct.machineLearningName)
        }
    }
}

class HistoryRecommendationEngineAdapter: RecommendationEngineAdapter {
    private struct HistoryServiceProduct {
        let historyId: String
        let historyName: String
    }

    private let historyServiceProducts = [
        HistoryServiceProduct(historyId: "1234", historyName: "Apple Watch Ultra"),
        HistoryServiceProduct(historyId: "4321", historyName: "Vision Pro"),
        HistoryServiceProduct(historyId: "2314", historyName: "iPhone Pro")
    ]

    func fetchProductRecommendations() -> [Product] {
        return historyServiceProducts.map { historyServiceProduct in
            Product(id: historyServiceProduct.historyId, name: historyServiceProduct.historyName)
        }
    }
}
```

#### Client:

Uses adapters to convert the various recommendation engine data structures to the common `Product` structure.

```swift
class RecommendationEngine {
    private let adapter: RecommendationEngineAdapter

    init(adapter: RecommendationEngineAdapter) {
        self.adapter = adapter
    }

    func fetchProductRecommendations() -> [Product] {
        return adapter.fetchProductRecommendations()
    }
}
```

## Example

```swift
let adapter = MachineLearningRecommendationEngineAdapter()
let recommendationEngine = RecommendationEngine(adapter: adapter)
let products = recommendationEngine.fetchProductRecommendations()

print(products) // [Product(id: "1234", name: "Apple Watch Ultra"), Product(id: "4321", name: "Vision Pro")]
```
