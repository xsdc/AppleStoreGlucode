import Testing
@testable import AppleStoreChainOfResponsibility

@Test func chainOfResponsibility() async throws {
    let inventoryCheckHandler = InventoryCheckHandler(nextHandler: nil)
    let authenticationHandler = AuthenticationHandler(nextHandler: inventoryCheckHandler)
    
    let bagService = BagService(handler: authenticationHandler)
}

public class MockAuthenticationService: AuthenticationService {
    public func logIn() async -> Result<Bool, Error> {
        return .success(true)
    }
}

public class MockInventoryService: InventoryService {
    public func checkIfProductIsInStock(productId: String) async -> Result<Bool, Error> {
        return .success(true)
    }
}
