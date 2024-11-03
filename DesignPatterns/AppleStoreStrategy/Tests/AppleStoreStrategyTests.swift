import Testing
@testable import AppleStoreStrategy

@Test func checkoutWithApplePayPaymentStrategy() async throws {
    let paymentStrategy = ApplePayPaymentStrategy(appleId: "test@icloud.com")
    
    let checkout = Checkout(paymentStrategy: paymentStrategy)
    let result = await checkout.processPayment(amount: 999)
    
    switch result {
    case .success(let success):
        #expect(success == .applePayPaymentSuccess)
    case .failure (let failure):
        Issue.record(failure)
    }
}

@Test func checkoutWithCreditCardPaymentStrategy() async throws {
    let paymentStrategy = CreditCardPaymentStrategy(creditCardNumber: 0123456789)
    
    let checkout = Checkout(paymentStrategy: paymentStrategy)
    let result = await checkout.processPayment(amount: 999)
    
    switch result {
    case .success(let success):
        #expect(success == .creditCardPaymentSuccess)
    case .failure (let failure):
        Issue.record(failure)
    }
}

@Test func checkoutWithGiftCardPaymentStrategy() async throws {
    let paymentStrategy = GiftCardPaymentStrategy(giftCard: "0123456789")
    
    let checkout = Checkout(paymentStrategy: paymentStrategy)
    let result = await checkout.processPayment(amount: 999)
    
    switch result {
    case .success(let success):
        #expect(success == .giftCardPaymentSuccess)
    case .failure (let failure):
        Issue.record(failure)
    }
}
