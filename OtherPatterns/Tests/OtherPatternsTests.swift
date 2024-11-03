import Testing
@testable import Sources

@Test func testDelegate() async throws {
    let parent = Parent()
    parent.setupDelegate()
    
    #expect(parent.child?.delegate.callParent() == true)
}
