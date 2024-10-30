import SwiftUI

public struct AppleStoreChainOfResponsibilityView: View {
    public init() {}
    
    public var body: some View {
        Text("AppleStoreChainOfResponsibility")
    }
}

public protocol AuthenticationService {
    func checkIfSessionIsValid() async -> Result<Bool, Error>
}

public protocol InventoryService {
    func checkIfProductIsInStock(productId: String) async -> Result<Bool, Error>
}

public struct Request {
    let productId: String
    let isPreorder: Bool
    let isAuthenticated: Bool
}

// Handler

public protocol Handler {
    var nextHandler: (any Handler)? { get set }
    func handle(request: Request) async -> Result<Bool, Error>
}

// Concrete handler

public class InventoryCheckHandler: Handler {
    public var inventoryService: InventoryService
    public var nextHandler: (any Handler)?
    
    public init(inventoryService: InventoryService, nextHandler: (any Handler)?) {
        self.inventoryService = inventoryService
        self.nextHandler = nextHandler
    }
    
    public func handle(request: Request) async -> Result<Bool, Error> {
        if request.isPreorder {
            return await nextHandler?.handle(request: request) ?? .success(true)
        }
        else {
            let result = await inventoryService.checkIfProductIsInStock(productId: request.productId)
            
            switch result {
            case .success:
                return await nextHandler?.handle(request: request) ?? .success(true)
            case .failure(let error):
                return .failure(error)
            }
        }
    }
}

public class AuthenticationHandler: Handler {
    public var authenticationService: AuthenticationService
    public var nextHandler: (any Handler)?
    
    public init(authenticationService: AuthenticationService, nextHandler: (any Handler)?) {
        self.authenticationService = authenticationService
        self.nextHandler = nextHandler
    }
    
    public func handle(request: Request) async -> Result<Bool, Error> {
        let result = await authenticationService.checkIfSessionIsValid()
        
        switch result {
        case .success:
            return await nextHandler?.handle(request: request) ?? .success(true)
        case .failure(let error):
            return .failure(error)
        }
    }
}

// Client

public struct BagService {
    let handler: Handler
    
    public init(handler: Handler) {
        self.handler = handler
    }
    
    public func addProductToBag(productId: String, isPreorder: Bool, isAuthenticated: Bool) async -> Result<Bool, Error> {
        let request = Request(productId: productId, isPreorder: isPreorder, isAuthenticated: isAuthenticated)
        return await handler.handle(request: request)
    }
}
