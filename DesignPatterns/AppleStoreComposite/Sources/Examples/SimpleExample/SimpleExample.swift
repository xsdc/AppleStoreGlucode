import SwiftUI

public struct SimpleExampleComposite {
    // Component
    public protocol CatalogItem: Hashable {
        var id: String { get }
        var name: String { get }
        func analyticsEvent() -> String
    }

    // Composite
    public struct CatalogCategory: CatalogItem {
        public let id: String
        public let name: String
        public var children: [any CatalogItem] = []
        
        public func analyticsEvent() -> String {
            return "catalog-category-" + id
        }

        public mutating func addItem(_ item: any CatalogItem) {
            children.append(item)
        }

        public mutating func removeItem(_ item: any CatalogItem) {
            if let index = children.firstIndex(where: { $0.id == item.id }) {
                children.remove(at: index)
            }
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

        public static func == (lhs: CatalogCategory, rhs: CatalogCategory) -> Bool {
            return lhs.id == rhs.id
        }
    }

    // Leaf
    public struct CatalogProduct: CatalogItem {
        public let id: String
        public let name: String
        public let description: String
        public let price: Double
        
        public func analyticsEvent() -> String {
            return "catalog-product-" + id
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

        public static func == (lhs: CatalogProduct, rhs: CatalogProduct) -> Bool {
            return lhs.id == rhs.id
        }
    }
}

public class SimpleExampleViewModel: ObservableObject {
    @Published public var rootCatalogCategory = SimpleExampleComposite.CatalogCategory(
        id: "0", name: "Catalog")

    public func addCategory() {
        var category = SimpleExampleComposite.CatalogCategory(
            id: UUID().uuidString, name: "Category")
        rootCatalogCategory.addItem(category)
    }

    public func addProduct() {
        let product = SimpleExampleComposite.CatalogProduct(
            id: UUID().uuidString,
            name: "Apple Vision Pro",
            description: "Seamlessly blends digital content with your physical space.",
            price: 999.00
        )
        rootCatalogCategory.addItem(product)
    }
}

public struct SimpleExampleView: View {
    @StateObject public var viewModel = SimpleExampleViewModel()

    public var body: some View {
        NavigationStack {
            if viewModel.rootCatalogCategory.children.isEmpty {
                ContentUnavailableView {
                    Label("No Components", systemImage: "cube")
                } description: {
                    Text("Add a category or product from the toolbar.")
                }
            } else {
                let categories = viewModel.rootCatalogCategory.children.compactMap {
                    $0 as? SimpleExampleComposite.CatalogCategory
                }
                
                let products = viewModel.rootCatalogCategory.children.compactMap {
                    $0 as? SimpleExampleComposite.CatalogProduct
                }
                
                List {
                    if !categories.isEmpty {
                        Section(header: Text("Categories")) {
                            ForEach(categories, id: \.id) { category in
                                Button(action: {
                                    print(category.analyticsEvent())
                                }) {
                                    HStack {
                                        Image(systemName: "cube")
                                            .padding(4)
                                        VStack {
                                            Text(category.name)
                                                .font(.headline)
                                        }
                                    }
                                    .padding(4)
                                    .frame(width: .infinity)
                                    .tint(.black)
                                }
                            }
                        }
                    }
                    
                    if !products.isEmpty {
                        Section(header: Text("Products")) {
                            ForEach(products, id: \.id) { product in
                                Button(action: {
                                    print(product.analyticsEvent())
                                }) {
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
                                    .frame(width: .infinity)
                                    .tint(.black)
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
