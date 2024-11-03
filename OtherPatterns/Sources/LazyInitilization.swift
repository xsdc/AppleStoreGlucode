
class LazyInitialization {
    lazy var getWhenNeeded: [String] = {
        var resourceIntensiveResult = (1...10000).map { "\($0)" }
        return resourceIntensiveResult
    }
}
