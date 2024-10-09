import SwiftUI

public struct NestedExampleComposite {
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

public class NestedExampleViewModel: ObservableObject {
    @Published public var rootComponent = NestedExampleComposite.Category(id: "0", name: "Catalog")
    
    public func addCategory() {
        var category = NestedExampleComposite.Category(id: UUID().uuidString, name: "Category")
        rootComponent.addComponent(category)
    }
    
    public func addProduct() {
        let product = NestedExampleComposite.Product(
            id: UUID().uuidString,
            name: "AirPods Pro",
            description: "Pro-level Active Noise Cancellation and a breakthrough in hearing health.",
            price: 999.00
        )
        rootComponent.addComponent(product)
    }
}

public struct NestedExampleView: View {
    @StateObject public var viewModel = NestedExampleViewModel()
    
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
                            $0 as? NestedExampleComposite.Category
                        }, id: \.id) { category in
                            NavigationLink(destination: CategoryView()) {
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
                    }
                    
                    Section(header: Text("Products")) {
                        ForEach(viewModel.rootComponent.children.compactMap {
                            $0 as? NestedExampleComposite.Product
                        }, id: \.id) { product in
                            HStack {
                                Image(systemName: "airpodspro")
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
        .navigationTitle("Nested Example")
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

public struct CategoryView: View {
    @StateObject public var viewModel = NestedExampleViewModel()
    
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
                            $0 as? NestedExampleComposite.Category
                        }, id: \.id) { category in
                            NavigationLink(destination: NestedExampleView()) {
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
                    }
                    
                    Section(header: Text("Products")) {
                        ForEach(viewModel.rootComponent.children.compactMap {
                            $0 as? NestedExampleComposite.Product
                        }, id: \.id) { product in
                            HStack {
                                Image(systemName: "airpodspro")
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
        .navigationTitle("Category")
    }
}

#Preview {
    NestedExampleView()
}

