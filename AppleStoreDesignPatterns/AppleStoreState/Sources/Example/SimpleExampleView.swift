import SwiftUI

public struct SimpleExampleView: View {
    public init() {}
    
    public var body: some View {
        NavigationStack {
            ContentUnavailableView {
                Label("Pending", systemImage: "clock")
            } description: {
                Text("Order #242342 has been placed.")
            }
            .navigationTitle("State")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button(action: {
                            
                        }) {
                            Text("Ship Order")
                        }
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Text("Cancel Order")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SimpleExampleView()
}
