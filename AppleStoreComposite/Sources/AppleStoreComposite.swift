import SwiftUI

public struct AppleStoreComposite: View {
    public init() {}

    public var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: SimpleExampleView()) {
                    Text("Simple Example")
                }
                
                NavigationLink(destination: NestedExampleView()) {
                    Text("Nested Example")
                }
            }
            .navigationTitle("Composite")
        }
    }
}

#Preview {
    AppleStoreComposite()
}
