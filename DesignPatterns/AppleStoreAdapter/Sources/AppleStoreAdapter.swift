import SwiftUI

public struct AppleStoreAdapterView: View {
    public init() {}
    
    public var body: some View {
        Text("AppleStoreAdapter")
    }
}

public struct AdapterFailure: Error {}

// Target

public struct Product {
    let id: String
    let name: String
}

// Client

public class RecommendationsService {
    static func getRecommendationsForUser(userId: String, recommendationEngine: RecommendationEngineAdapter) async -> Result<[Product], AdapterFailure> {
        return await recommendationEngine.getRecommendationsForUser(userId: userId)
    }
}

// Adaptee

public protocol RecommendationEngineAdapter {
    func getRecommendationsForUser(userId: String) async -> Result<[Product], AdapterFailure>
}

// Adapters

public struct MachineLearningRecommendationEngine: RecommendationEngineAdapter {
    struct MachineLearningServiceProduct {
        let machineLearningId: String
        let machineLearningName: String
    }
    
    let machineLearningServiceProducts = [
        MachineLearningServiceProduct(machineLearningId: "1234", machineLearningName: "Apple Watch Ultra"),
        MachineLearningServiceProduct(machineLearningId: "4321", machineLearningName: "Vision Pro")
    ]
    
    public func getRecommendationsForUser(userId: String) async -> Result<[Product], AdapterFailure> {
        let products: [Product] = machineLearningServiceProducts.map { machineLearningProduct in
            Product(id: machineLearningProduct.machineLearningId, name: machineLearningProduct.machineLearningName)
        }
        
        return .success(products)
    }
}

public struct HistoryRecommendationEngine: RecommendationEngineAdapter {
    struct HistoryServiceProduct {
        let historyId: String
        let historyName: String
        let extraField: Bool
    }
    
    let historyServiceProducts = [
        HistoryServiceProduct(historyId: "1234", historyName: "Apple Watch Ultra", extraField: true),
        HistoryServiceProduct(historyId: "4321", historyName: "Vision Pro", extraField: false),
        HistoryServiceProduct(historyId: "2314", historyName: "iPhone Pro", extraField: true)
    ]
    
    public func getRecommendationsForUser(userId: String) async -> Result<[Product], AdapterFailure> {
        let products: [Product] = historyServiceProducts.map { historyServiceProduct in
            Product(id: historyServiceProduct.historyId, name: historyServiceProduct.historyName)
        }
        
        return .success(products)
    }
}
