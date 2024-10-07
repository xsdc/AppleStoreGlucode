import Foundation

public struct SimpleExampleState {
    protocol NotificationService {
          func sendMessage(_ message: String)
    }
    
    struct Order {
        let id: String
        let notificationService: NotificationService
        var orderState: OrderState
        
        mutating func update(state: OrderState) {
            orderState = state
        }
    }
    
    protocol OrderState {
        func getStateName() -> String
        func getStateDescription() -> String
        func getStateIcon() -> String
        mutating func shipOrder()
        mutating func cancelOrder()
    }
    
    struct PendingOrderState: OrderState {
        var order: Order
        
        func getStateName() -> String {
            return "Pending"
        }
        
        func getStateDescription() -> String {
            return "Order #\(order.id) has been placed."
        }
        
        func getStateIcon() -> String {
            return "clock"
        }
        
        mutating func shipOrder() {
            order.notificationService.sendMessage("Order #\(order.id) has been shipped.")
            order.update(state: ShippedOrderState(order: order))
        }
        
        mutating func cancelOrder() {
            order.notificationService.sendMessage("Order #\(order.id) has been cancelled.")
            order.update(state: CancelledOrderState(order: order))
        }
    }
    
    struct ShippedOrderState: OrderState {
        var order: Order
        
        func getStateName() -> String {
            return "Shipped"
        }
        
        func getStateDescription() -> String {
            return "Order #\(order.id) has been shipped."
        }
        
        func getStateIcon() -> String {
            return "shippingbox"
        }
        
        mutating func shipOrder() {
            order.notificationService.sendMessage("Order #\(order.id) is already on the way.")
            order.update(state: ShippedOrderState(order: order))
        }
        
        mutating func cancelOrder() {
            order.notificationService.sendMessage("Order #\(order.id) has been cancelled, and will return to Apple.")
            order.update(state: CancelledOrderState(order: order))
        }
    }
    
    struct CancelledOrderState: OrderState {
        var order: Order
        
        func getStateName() -> String {
            return "Cancelled"
        }
        
        func getStateDescription() -> String {
            return "Order #\(order.id) has been cancelled."
        }
        
        func getStateIcon() -> String {
            return "xmark.circle"
        }
        
        mutating func shipOrder() {
            order.notificationService.sendMessage("Order #\(order.id) has been shipped.")
            order.update(state: ShippedOrderState(order: order))
        }
        
        mutating func cancelOrder() {
            order.notificationService.sendMessage("Order #\(order.id) has already been cancelled.")
        }
    }
}
