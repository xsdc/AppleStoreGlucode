![Facade](https://github.com/user-attachments/assets/b4217919-558b-4b46-b5ba-de31f8bc8a5d)

<br />

# Facade

> Provide a unified interface to a set of interfaces in a subsystem. Facade defines a higher-level interface that makes the subsystem easier to use.
>
> _Reference: Design Patterns: Elements of Reusable Object-Oriented Software_

## Pattern overview

- The Facade pattern provides a simple way to complete tasks where many underlying parts are needed.

- These parts are encapsulated in an object, which provides a simple interface to perform the tasks.

## Problem statement

- Once orders are processed on the Apple Store, notifications are sent to the customer.

- At the moment, this is initiated on the server. Let's imagine that we are tasked to implement notification processing from the app.

- Once an order is processed, we need to send a notification to the customer.

- We have two notification APIs that we have implemented: `MailNotificationAPI` and `MessageNotificationAPI`.

- We also have a `Settings` class that handles all the settings for the app, including the notification type selected by the user.

- Once an order is processed, we want to avoid exposing the objects we need to use to send a notification: `Settings`, `MailNotificationAPI`, and `MessageNotificationAPI`.

- The Facade pattern allows us to combine these classes into a single class that can handle the notification processing.

- This is all done without exposing the complexity of the underlying objects.

## Definitions

#### Subsystem classes:

- Implements the functionality of the subsystems.

- They are decoupled from the Facade object.

```swift
struct Settings {
    enum NotificationType {
        case mail
        case message
    }

    var notificationType: NotificationType
}

struct MailNotificationAPI {
    func sendMail(with text: String) {
        print("Mail sent with text: \(text)")
    }
}

struct MessageNotificationAPI {
    func sendMessage(with text: String) {
        print("Message sent with text: \(text)")
    }
}
```

#### Facade:

- Maintains references to subsystem classes.

- Delegates work to subsystem classes.

```swift
struct NotificationFacade {
    private let mailNotificationAPI = MailNotificationAPI()
    private let messageNotificationAPI = MessageNotificationAPI()
    private let settings = Settings(notificationType: .mail)

    func send(text: String) {
        switch settings.notificationType {
        case .mail:
            mailNotificationAPI.sendMail(with: text)
        case .message:
            messageNotificationAPI.sendMessage(with: text)
        }
    }
}
```

## Example

```swift
let notificationFacade = NotificationFacade()
notificationFacade.send(text: "Order processed.") // Mail sent with text: Order processed.
```
