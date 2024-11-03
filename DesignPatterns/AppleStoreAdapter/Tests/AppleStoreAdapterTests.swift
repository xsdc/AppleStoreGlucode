import Testing
@testable import AppleStoreAdapter

@Test func testMachineLearningRecommendationEngine() async throws {
    let recommendationEngine = MachineLearningRecommendationEngine()
    
    let result = await RecommendationsService.getRecommendationsForUser(
        userId: "test@icloud.com",
        recommendationEngine: recommendationEngine
    )
    
    switch result {
    case .success(let products):
        #expect(products.count == 2)
    case .failure (let failure):
        Issue.record(failure)
    }
}

@Test func testHistoryRecommendationEngine() async throws {
    let recommendationEngine = HistoryRecommendationEngine()
    
    let result = await RecommendationsService.getRecommendationsForUser(
        userId: "test@icloud.com",
        recommendationEngine: recommendationEngine
    )
    
    switch result {
    case .success(let products):
        #expect(products.count == 3)
    case .failure (let failure):
        Issue.record(failure)
    }
}
