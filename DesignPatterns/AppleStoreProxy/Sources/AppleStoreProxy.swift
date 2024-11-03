import SwiftUI

public struct AppleStoreProxyView: View {
    public init() {}

    public var body: some View {
        Text("AppleStoreProxy")
    }
}

public enum ProxySuccess {
    case bagClearSuccess
    case authenticationSuccess
}

public enum ProxyFailure: Error {
    case bagClearFailure
    case authenticationFailure
}

public protocol BaseBagService {
    func clear() async -> Result<ProxySuccess, ProxyFailure>
}

public struct BagService: BaseBagService {
    public func clear() async -> Result<ProxySuccess, ProxyFailure> {
        return .success(.bagClearSuccess)
    }
}

public struct AuthenticationProxyForBagService: BaseBagService {
    let bagService: BaseBagService
    let authenticationService: AuthenticationService
    
    public func clear() async -> Result<ProxySuccess, ProxyFailure> {
        let result = await authenticationService.checkIfSessionIsValid()
        
        guard case .success = result else {
            return result
        }
        
        return await bagService.clear()
    }
}

public protocol AuthenticationService {
    func checkIfSessionIsValid() async -> Result<ProxySuccess, ProxyFailure>
}
