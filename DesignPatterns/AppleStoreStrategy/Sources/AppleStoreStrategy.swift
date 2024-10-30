import SwiftUI

public struct AppleStoreStrategyView: View {
    public init() {}
    
    public var body: some View {
        Text("AppleStoreStrategy")
    }
}

public enum StrategySuccess {
    case applePayPaymentSuccess
    case creditCardPaymentSuccess
    case giftCardPaymentSuccess
}

public enum StrategyFailure: Error {
    case failure
}

public protocol PaymentStrategy {
    func pay(amount: Double) async -> Result<StrategySuccess, StrategyFailure>
}

public struct ApplePayPaymentStrategy: PaymentStrategy {
    let appleId: String
    
    public func pay(amount: Double) async -> Result<StrategySuccess, StrategyFailure> {
        return .success(.applePayPaymentSuccess)
    }
}

public struct CreditCardPaymentStrategy: PaymentStrategy {
    let creditCardNumber: Int
    
    public func pay(amount: Double) async -> Result<StrategySuccess, StrategyFailure> {
        return .success(.creditCardPaymentSuccess)
    }
}

public struct GiftCardPaymentStrategy: PaymentStrategy {
    let giftCard: String
    
    public func pay(amount: Double) async -> Result<StrategySuccess, StrategyFailure> {
        return .success(.giftCardPaymentSuccess)
    }
}

public struct Checkout {
    var paymentStrategy: PaymentStrategy
    
    public func processPayment(amount: Double) async -> Result<StrategySuccess, StrategyFailure> {
        let result = await paymentStrategy.pay(amount: amount)
        
        return result
    }
}
