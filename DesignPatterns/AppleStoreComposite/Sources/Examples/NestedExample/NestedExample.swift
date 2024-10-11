import SwiftUI

public struct NestedExampleComposite {
    // Component
    public protocol CatalogItem: Hashable {
        var parent: (any NestedExampleComposite.CatalogItem)? { get }
        
        var id: String { get }
        
        var name: String { get }
        
        func path() -> [String]
    }
    
    // Composite
    public class CatalogCategory: CatalogItem, ObservableObject {
        public var parent: (any NestedExampleComposite.CatalogItem)?
        
        public let id: String
        
        public let name: String
        
        @Published public var children: [any CatalogItem] = []
        
        public init(parent: (any NestedExampleComposite.CatalogItem)?, id: String, name: String) {
            self.parent = parent
            self.id = id
            self.name = name
        }
        
        public func path() -> [String] {
            var path: [String] = [name]
            var nextParent: (any NestedExampleComposite.CatalogItem)? = parent
            
            while let currentParent = nextParent {
                path.append(currentParent.name)
                
                nextParent = currentParent.parent
            }
            
            return path
        }
        
        public func addCategory(name: String) {
            var category = NestedExampleComposite.CatalogCategory(
                parent: self,
                id: UUID().uuidString,
                name: name
            )
            
            children.append(category)
        }
        
        public func addProduct() {
            let product = NestedExampleComposite.CatalogProduct(
                parent: self,
                id: UUID().uuidString,
                name: "AirPods Pro",
                description: "Pro-level Active Noise Cancellation and a breakthrough in hearing health.",
                price: 999.00
            )
            
            children.append(product)
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
        public var parent: (any NestedExampleComposite.CatalogItem)?
        
        public let id: String
        
        public let name: String
        
        public let description: String
        
        public let price: Double
        
        public func path() -> [String] {
            var path: [String] = [name]
            var nextParent: (any NestedExampleComposite.CatalogItem)? = parent
            
            while let currentParent = nextParent {
                path.append(currentParent.name)
                
                nextParent = currentParent.parent
            }
            
            return path
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        public static func == (lhs: CatalogProduct, rhs: CatalogProduct) -> Bool {
            return lhs.id == rhs.id
        }
    }
}

public struct NestedExampleView: View {
    @StateObject public var rootCatalogCategory = NestedExampleComposite.CatalogCategory(parent: nil, id: "0", name: "Catalog")
    
    public var body: some View {
        NavigationStack {
            NestedExampleCategoryView(parentCategory: rootCatalogCategory)
        }
    }
}

public struct NestedExampleCategoryView: View {
    @ObservedObject public var parentCategory: NestedExampleComposite.CatalogCategory
    
    @State private var selectedProduct: NestedExampleComposite.CatalogProduct?
    
    @State private var productSheetIsPresented = false
    
    @State private var categorySheetIsPresented = false
    
    @State private var alertIsPresented = false
    
    @State private var categoryName = ""
    
    public var body: some View {
        Group {
            if parentCategory.children.isEmpty {
                ContentUnavailableView {
                    Label("No Components", systemImage: "cube")
                } description: {
                    Text("Add a category or product from the toolbar.")
                }
            }
            else {
                let categories = parentCategory.children.compactMap {
                    $0 as? NestedExampleComposite.CatalogCategory
                }
                
                let products = parentCategory.children.compactMap {
                    $0 as? NestedExampleComposite.CatalogProduct
                }
                
                List {
                    if !categories.isEmpty {
                        Section(header: Text("Categories")) {
                            ForEach(categories, id: \.id) { category in
                                let destination = NestedExampleCategoryView(parentCategory: category)
                                NavigationLink(destination: destination) {
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
                    }
                    
                    if !products.isEmpty {
                        Section(header: Text("Products")) {
                            ForEach(products, id: \.id) { product in
                                Button(action: {
                                    selectedProduct = product
                                    productSheetIsPresented = true
                                }) {
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
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
            }
        }
        .alert("Add Category", isPresented: $alertIsPresented) {
            TextField("Category", text: $categoryName)
            Button("Add", action: {
                if !categoryName.isEmpty {
                    parentCategory.addCategory(name: categoryName)
                    categoryName = ""
                }
            })
            Button("Cancel", role: .cancel) {
                alertIsPresented = false
            }
        }
        .navigationTitle(parentCategory.name)
        .sheet(isPresented: $categorySheetIsPresented) {
            NestedExamplePathView(path: parentCategory.path())
        }
        .sheet(isPresented: $productSheetIsPresented) {
            if let path = selectedProduct?.path() {
                NestedExamplePathView(path: path)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    categorySheetIsPresented = true
                }) {
                    Image(systemName: "list.bullet.indent")
                }
            }
            
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Button(action: {
                        alertIsPresented = true
                    }) {
                        Text("Add Category")
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        parentCategory.addProduct()
                    }) {
                        Text("Add Product")
                    }
                }
            }
        }
    }
}

struct NestedExamplePathView: View {
    let path: [String]
    
    public var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Path")) {
                    ForEach(path, id: \.self) { category in
                        Text(category)
                    }
                }
            }
        }
    }
}

#Preview {
    NestedExampleView()
}
