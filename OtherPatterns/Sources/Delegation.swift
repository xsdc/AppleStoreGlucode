
protocol ChildDelegate {
    func callParent() -> Bool
}

public class Parent {
    var child: Child?
    
    func setupDelegate() {
        child = Child(delegate: self)
    }
}

extension Parent: ChildDelegate {
    func callParent() -> Bool {
        return true
    }
}

class Child {
    var delegate: ChildDelegate
    
    init(delegate: ChildDelegate) {
        self.delegate = delegate
    }
}
