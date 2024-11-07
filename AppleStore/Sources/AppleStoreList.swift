import SwiftUI

import AppleStoreAdapter
import AppleStoreBridge
import AppleStoreBuilder
import AppleStoreChainOfResponsibility
import AppleStoreCommand
import AppleStoreComposite
import AppleStoreDecorator
import AppleStoreFacade
import AppleStoreIterator
import AppleStoreMediator
import AppleStoreMemento
import AppleStoreObserver
import AppleStorePrototype
import AppleStoreProxy
import AppleStoreSingleton
import AppleStoreState
import AppleStoreStrategy
import AppleStoreTemplateMethod
import AppleStoreVisitor

struct AppleStoreList: View {
    var body: some View {
        List {
            Section(header: Text("Creational")) {
                NavigationLink(destination: AppleStoreBuilderView()) {
                    Text("Builder")
                }
                NavigationLink(destination: AppleStorePrototypeView()) {
                    Text("Prototype")
                }
                NavigationLink(destination: AppleStoreSingletonView()) {
                    Text("Singleton")
                }
            }
            Section(header: Text("Structural")) {
                NavigationLink(destination: AppleStoreAdapterView()) {
                    Text("Adapter")
                }
                NavigationLink(destination: AppleStoreBridgeView()) {
                    Text("Bridge")
                }
                NavigationLink(destination: AppleStoreComposite()) {
                    Text("Composite")
                }
                NavigationLink(destination: AppleStoreDecoratorView()) {
                    Text("Decorator")
                }
                NavigationLink(destination: AppleStoreFacadeView()) {
                    Text("Facade")
                }
                NavigationLink(destination: AppleStoreProxyView()) {
                    Text("Proxy")
                }
            }
            Section(header: Text("Behavioral")) {
                NavigationLink(destination: AppleStoreChainOfResponsibilityView()) {
                    Text("Chain of Responsibility")
                }
                NavigationLink(destination: AppleStoreCommandView()) {
                    Text("Command")
                }
                NavigationLink(destination: AppleStoreIteratorView()) {
                    Text("Iterator")
                }
                NavigationLink(destination: AppleStoreObserverView()) {
                    Text("Observer")
                }
                NavigationLink(destination: AppleStoreMediatorView()) {
                    Text("Mediator")
                }
                NavigationLink(destination: AppleStoreMementoView()) {
                    Text("Memento")
                }
                NavigationLink(destination: AppleStoreVisitorView()) {
                    Text("Visitor")
                }
                NavigationLink(destination: AppleStoreTemplateMethodView()) {
                    Text("Template Method")
                }
                NavigationLink(destination: AppleStoreStrategyView()) {
                    Text("Strategy")
                }
                NavigationLink(destination: AppleStoreStateView()) {
                    Text("State")
                }
            }
        }
        .navigationTitle("Apple Store")
    }
}
