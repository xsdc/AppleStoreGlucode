<br />

# Proxy

> Provide a surrogate or placeholder for another object to control access to it.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Proxy pattern provides a layer that may be used to add behavior to a class.
- Common uses include controlling access to a class, adding logging, or to add caching.
- It is often used in situations where you want to add behavior to a class without changing the class itself.

## Problem statement

- We want to add an authentication check to a service that clears a users Apple Store bag without changing the service itself.

## Domain application

Proxy:

- Maintains a reference that lets the proxy access the real subject.
- Proxy may refer to a Subject if the RealSubject and Subject interfaces are the same.
- Provides an interface identical to Subject's so that a proxy can by substituted for the real subject.
- Controls access to the real subject and may be responsible for creating and deleting it.

```swift
class AuthenticationProxyForBagService: BaseBagService {
    let bagService: BaseBagService
    let authenticationService: AuthenticationService

    func clear() async -> Result<Bool, Error> {
        let result = await authenticationService.checkIfSessionIsValid()

        guard case .success = result else {
            return result
        }

        return await bagService.clear()
    }
}
```

Subject:

Defines the common interface for RealSubject and Proxy so that a Proxy can be used anywhere a RealSubject is expected.

```swift
protocol BaseBagService {
    func clear() async -> Result<Bool, Error>
}
```

RealSubject:

Defines the real object that the proxy represents.

```swift
class BagService: BaseBagService {
    func clear() async -> Result<ProxySuccess, ProxyFailure> {
        return .success(.bagClearSuccess)
    }
}
```
