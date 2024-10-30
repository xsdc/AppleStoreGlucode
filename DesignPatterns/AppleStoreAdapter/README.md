<br />

# Adapter

> Convert the interface of a class into another interface clients expect. Adapter lets classes work together that couldn't otherwise because of incompatible interfaces.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Adapter pattern is a structural pattern that allows objects with incompatible interfaces to collaborate.
- For example, for a weather application that uses multiple third-party services, each service may have a different interface.
- The pattern can be used to create a common interface for all services to interact with the services in a consistent manner.

## Problem statement

- The Apple Store may have multiple product recommendation engines, each with their own service.
- These services are not compatible with each other.
- To simplify this, we'll use the Adapter pattern to create a common interface.

## Domain application

Target:

Defines the domain-specific interface that Client uses.

```swift
struct Product {
    let id: String
    let name: String
}
```

Client:

Collaborates with objects conforming to the Target interface.

```swift
class RecommendationsService {
    func getRecommendations(engine: RecommendationEngineAdapter) -> [Product] {
        return recommendationEngine.getRecommendations()
    }
}
```

Adaptee:

Defines an existing interface that needs adapting.

```swift
protocol RecommendationEngineAdapter {
    func getRecommendations() -> [Product]
}
```

Adapter:

Adapts the interface of Adaptee to the Target interface.

```swift
struct MachineLearningRecommendationEngine: RecommendationEngineAdapter {
    struct MachineLearningServiceProduct {
        let machineLearningId: String
        let machineLearningName: String
    }

    let machineLearningServiceProducts = [
        MachineLearningServiceProduct(machineLearningId: "1234", machineLearningName: "Apple Watch Ultra"),
        MachineLearningServiceProduct(machineLearningId: "4321", machineLearningName: "Vision Pro")
    ]

    func getRecommendations() -> [Product] {
        return machineLearningServiceProducts.map { machineLearningProduct in
            Product(id: machineLearningProduct.machineLearningId, name: machineLearningProduct.machineLearningName)
        }
    }
}

struct HistoryRecommendationEngine: RecommendationEngineAdapter {
    struct HistoryServiceProduct {
        let historyId: String
        let historyName: String
    }

    let historyServiceProducts = [
        HistoryServiceProduct(historyId: "1234", historyName: "Apple Watch Ultra"),
        HistoryServiceProduct(historyId: "4321", historyName: "Vision Pro"),
        HistoryServiceProduct(historyId: "2314", historyName: "iPhone Pro")
    ]

    func getRecommendations() -> [Product] {
        return historyServiceProducts.map { historyServiceProduct in
            Product(id: historyServiceProduct.historyId, name: historyServiceProduct.historyName)
        }
    }
}
```
