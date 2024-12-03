![Bridge](https://github.com/user-attachments/assets/8d1e0afd-4f2c-4fe5-9000-01c540b1fad3)

<br />

* Bridge

> Decouple an abstraction from its implementation so that the two can vary independently.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Bridge pattern allows for two separate but related objects to work together while keeping them decoupled.

- It is particularly useful when there are multiple variations of both the abstraction and the implementation that need to be combined in different ways.

## Problem statement

- Given a particular Apple Store product object, there are different visual representations of it that are possible, such as a summary view, a tech specs view, etc.

- Each product also has more granular components, such as a title view, a price view, a carousel view, etc.

- With the larger components and smaller components in mind, these can also vary based on the device used to view the product.

- This give rise to a complex explosion of possibilities for how the product can be rendered.

- To tame this complexity, the Bridge pattern can be used to separate the product view from the product components, allowing for different combinations of components to be used to render the view.

- The components can then be used by concrete implementation of `ProductView`

## Definitions

#### Implementor:

- Sets up the interface for the component renderers.

- These can be grouped by device type, such as iPhone, iPad, etc.

```swift
protocol ProductComponentRenderer {
    func renderTitleView(for product: Product) -> ComponentView
    func renderPriceView(for product: Product) -> ComponentView
    func renderCarouselView(for product: Product) -> ComponentView
    func renderTechSpecsView(for product: Product) -> ComponentView
}
```

#### Concrete implementos:

- For each device, a set of components can be grouped as an implementor of `ProductComponentRenderer`.

- Each component can be rendered in a different way based on the device used.

- The fonts, colors, and layout can be adjusted as needed.

````swift
struct iPhoneProductComponentRenderer: ProductComponentRenderer {
    func renderTitleView(for product: Product) -> ComponentView {
        return ComponentView(name: "Title view for iPhone")
    }

    func renderPriceView(for product: Product) -> ComponentView {
        return ComponentView(name: "Price view for iPhone")
    }

    func renderCarouselView(for product: Product) -> ComponentView {
        return ComponentView(name: "Carousel view for iPhone")
    }

    func renderTechSpecsView(for product: Product) -> ComponentView {
        return ComponentView(name: "Tech specs view for iPhone")
    }
}

struct iPadProductComponentRenderer: ProductComponentRenderer {
    func renderTitleView(for product: Product) -> ComponentView {
        return ComponentView(name: "Title view for iPad")
    }

    func renderPriceView(for product: Product) -> ComponentView {
        return ComponentView(name: "Price view for iPad")
    }

    func renderCarouselView(for product: Product) -> ComponentView {
        return ComponentView(name: "Carousel view for iPad")
    }

    func renderTechSpecsView(for product: Product) -> ComponentView {
        return ComponentView(name: "Tech specs view for iPad")
    }
}
````

#### Abstraction:

- The interface for the product view.

- Based on the component renderer, we are able to generate various visual representations of the product.

```swift
protocol RenderableProductView {
    var product: Product { get }
    var componentRenderer: ProductComponentRenderer { get }

    func render()
}
```

#### Refined Abstraction:

- The implementation for each product view.

- Each product view can be rendered in different ways based on the device used via the component renderer.

- Variations can be created as needed based on what the component renderer makes available.

```swift
class AppleWatchSummaryView: RenderableProductView {
    private(set) var views: [ComponentView] = []
    private(set) var product: Product
    private(set) var componentRenderer: ProductComponentRenderer

    init(product: Product, componentRenderer: ProductComponentRenderer) {
        self.product = product
        self.componentRenderer = componentRenderer
    }

    func render() {
        views.append(componentRenderer.renderTitleView(for: product))
        views.append(componentRenderer.renderPriceView(for: product))
        views.append(componentRenderer.renderCarouselView(for: product))
    }
}

class AppleWatchTechSpecsView: RenderableProductView {
    private(set) var views: [ComponentView] = []
    private(set) var product: Product
    private(set) var componentRenderer: ProductComponentRenderer

    init(product: Product, componentRenderer: ProductComponentRenderer) {
        self.product = product
        self.componentRenderer = componentRenderer
    }

    func render() {
        views.append(componentRenderer.renderTitleView(for: product))
        views.append(componentRenderer.renderPriceView(for: product))
        views.append(componentRenderer.renderTechSpecsView(for: product))
    }
}
```

## Example

```swift
struct ComponentView {
    let name: String
}

struct Product {
    let name: String
    let price: Double
}

let product = Product(name: "Apple Watch Ultra", price: 399.99)

// User wants to view the summary of an Apple Watch Ultra via an iPhone
let iPhoneRenderer = iPhoneProductComponentRenderer()
var summaryView = AppleWatchSummaryView(product: product, componentRenderer: iPhoneRenderer)
summaryView.render()
print(summaryView.views.map { $0.name }.joined(separator: "\n"))
// Output:
// Title view for iPhone
// Price view for iPhone
// Carousel view for iPhone

// User wants to view the tech specs of an Apple Watch Ultra via an iPad
let iPadRenderer = iPadProductComponentRenderer()
var techSpecsView = AppleWatchTechSpecsView(product: product, componentRenderer: iPadRenderer)
techSpecsView.render()
print(techSpecsView.views.map { $0.name }.joined(separator: "\n"))
// Output:
// Title view for iPad
// Price view for iPad
// Tech specs view for iPad
```
