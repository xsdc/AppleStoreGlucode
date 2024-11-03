import Testing
@testable import AppleStoreProxy

struct MockSuccessfulAuthenticationService: AuthenticationService {
    func checkIfSessionIsValid() async -> Result<ProxySuccess, ProxyFailure> {
        return .success(.authenticationSuccess)
    }
}

struct MockFailedAuthenticationService: AuthenticationService {
    func checkIfSessionIsValid() async -> Result<ProxySuccess, ProxyFailure> {
        return .failure(.authenticationFailure)
    }
}

@Test func successfulAuthenticationProxy() async throws {
    let bagService = BagService()
    let authenticationService = MockSuccessfulAuthenticationService()
    let proxy = AuthenticationProxyForBagService(bagService: bagService, authenticationService: authenticationService)
    let result = await proxy.clear()
    
    switch result {
    case .success(let success):
        #expect(success == .bagClearSuccess)
    case .failure (let failure):
        Issue.record(failure)
    }
}

@Test func failedAuthenticationProxy() async throws {
    let bagService = BagService()
    let authenticationService = MockFailedAuthenticationService()
    let proxy = AuthenticationProxyForBagService(bagService: bagService, authenticationService: authenticationService)
    let result = await proxy.clear()
    
    switch result {
    case .success(_):
        Issue.record("Failed")
    case .failure (let failure):
        #expect(failure == .authenticationFailure)
    }
}
