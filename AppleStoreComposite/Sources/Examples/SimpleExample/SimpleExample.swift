import SwiftUI

public struct SimpleExampleComposite {
    public protocol Component: Hashable {
        var id: String { get }
        var name: String { get }
    }
    
    public struct Category: Component {
        public let id: String
        public let name: String
        public var children: [any Component] = []
        
        public mutating func addComponent(_ component: any Component) {
            children.append(component)
        }
        
        public mutating func removeComponent(_ component: any Component) {
            if let index = children.firstIndex(where: { $0.id == component.id }) {
                children.remove(at: index)
            }
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        public static func == (lhs: Category, rhs: Category) -> Bool {
            return lhs.id == rhs.id
        }
    }
    
    public struct Product: Component {
        public let id: String
        public let name: String
        public let description: String
        public let price: Double
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        public static func == (lhs: Product, rhs: Product) -> Bool {
            return lhs.id == rhs.id
        }
    }
}

public class SimpleExampleViewModel: ObservableObject {
    @Published public var rootComponent = SimpleExampleComposite.Category(id: "0", name: "Catalog")
    
    public func addCategory() {
        var category = SimpleExampleComposite.Category(id: UUID().uuidString, name: "Category")
        rootComponent.addComponent(category)
    }
    
    public func addProduct() {
        let product = SimpleExampleComposite.Product(
            id: UUID().uuidString,
            name: "Apple Vision Pro",
            description: "Seamlessly blends digital content with your physical space.",
            price: 999.00
        )
        rootComponent.addComponent(product)
    }
}

public struct SimpleExampleView: View {
    @StateObject public var viewModel = SimpleExampleViewModel()
    
    public var body: some View {
        NavigationStack {
            if viewModel.rootComponent.children.isEmpty {
                ContentUnavailableView {
                    Label("No Components", systemImage: "cube")
                } description: {
                    Text("Add a category or product from the toolbar.")
                }
            }
            else {
                List {
                    Section(header: Text("Categories")) {
                        ForEach(viewModel.rootComponent.children.compactMap {
                            $0 as? SimpleExampleComposite.Category
                        }, id: \.id) { category in
                            HStack {
                                Image(systemName: "cube")
                                    .padding(4)
                                VStack {
                                    Text(category.name)
                                        .font(.headline)
                                }
                            }
                            .padding(4)
                        }
                    }
                    
                    Section(header: Text("Products")) {
                        ForEach(viewModel.rootComponent.children.compactMap {
                            $0 as? SimpleExampleComposite.Product
                        }, id: \.id) { product in
                            HStack {
                                Image(systemName: "visionpro")
                                    .padding(4)
                                VStack(alignment: .leading) {
                                    Text(product.name)
                                        .font(.subheadline)
                                    Text(product.description)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Simple Example")
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Button(action: {
                        viewModel.addCategory()
                    }) {
                        Text("Add Category")
                    }
                    Spacer()
                    Button(action: {
                        viewModel.addProduct()
                    }) {
                        Text("Add Product")
                    }
                }
            }
        }
    }
}

#Preview {
    SimpleExampleView()
}
