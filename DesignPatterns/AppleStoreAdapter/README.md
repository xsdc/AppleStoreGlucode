![Adapter](https://github.com/user-attachments/assets/1ade6f0e-2ca8-4821-b319-64784de1d353)

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

>>> RB: the problem isn't that the SERVICES are incompatible with each other. Services don't talk to each other. Rather there is likely a repo which needs to consume data from different services, and since each service returns different data types we need to adapt those responses into a unified API which the repo can consume.

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

>>> RB: Why is the client a service?? In all your above explanations services are the things with incompatible API's. Call this the RecommendationsRepo. 

Collaborates with objects conforming to the Target interface.

```swift
class RecommendationsService {
    func getRecommendations(engine: RecommendationEngineAdapter) -> [Product] {
    
    // >>> RB: a) your method signature doesn't alignw with Swift API guidelines. It should be recommendations(from recommendationEngineAdapter: RecommendationEngineAdapter) -> [Product]
    // >>> RB: b) you call `recommendationEngine` but your parameter name is `engine`. 
        return recommendationEngine.getRecommendations()
    }
}
```
// RB >>> This doesn't make sense. "Defines an existing interface": in what sense is it "an existing interface" given that you are defining it? And in what sense does it "need adapting"? Do you mean: "Defines an interface that ensures objects which conform to it expose a consistent API for consumers"?
// RB >>> Is "Adaptee" taken from docs somewhere? Adaptee seems to me to be a concrete object which needs to be adapted. And I woudld imagine the Adapter is the interface itself.  

Adaptee:

Defines an existing interface that needs adapting.

```swift
protocol RecommendationEngineAdapter {
    func getRecommendations() -> [Product]
}
```

Adapter:

Adapts the interface of Adaptee to the Target interface.

// RB: >>> Zero access control on this class. The getRecommendations method should be the only public method. It is super important that example code is of the highest quality. 
```swift
class MachineLearningRecommendationEngine: RecommendationEngineAdapter {
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

class HistoryRecommendationEngine: RecommendationEngineAdapter {
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
