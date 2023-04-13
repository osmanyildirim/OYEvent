//
//  OYEvent.swift
//  OYEvent
//
//  Created by osmanyildirim
//

import Foundation

/// NotificationCenter is notification dispatch mechanism that enables the broadcast of information to registered observers.
/// https://developer.apple.com/documentation/foundation/notificationcenter
///
/// `OYEvent` helps to post and observe notifications

public protocol OYEventProtocol: OYDisposable {
    /// Closure type for `completion`
    typealias Completable = (_ notification: Notification) -> Void
    
    /// Add an observer for a notification and observe
    /// - Parameters:
    ///   - target: AnyObject instance, e.g. `UIViewController`
    ///   - name: notification method name of `String` type
    ///   - on: a queue to dispatch on
    ///   - completion: a callback that will fire
    ///
    /// Usage:
    ///
    ///     OYEvent.observe(target: self, name: "Method_Name", on: .main) { notification in
    ///         // do stuff
    ///     }
    static func observe(target: AnyObject, name: String, on queue: OperationQueue?, completion: Completable?)
    
    /// Add an observer for a notification and observe
    /// - Parameters:
    ///   - target: AnyObject instance, e.g. `UIViewController`
    ///   - name: notification name of `NSNotification.Name` type
    ///   - on: a queue to dispatch on
    ///   - completion: a callback that will fire
    ///
    /// Usage:
    ///
    ///      OYEvent.observe(target: self, name: Notification.Name(rawValue: UIResponder.keyboardWillShowNotification.rawValue), on: .main) { notification in
    ///          // do stuff
    ///      }
    static func observe(target: AnyObject, name: NSNotification.Name, on queue: OperationQueue?, completion: Completable?)
    
    /// Post a notification
    /// - Parameters:
    ///   - name: notification method name of `String` type
    ///   - userInfo: optional object to send with the notification of `[AnyHashable: Any]` type.  default value is `nil`
    ///
    /// Usage:
    ///
    ///     OYEvent.post(name: "Method_Name", userInfo: ["Key": "Value"])
    static func post(name: String, userInfo: [AnyHashable: Any]?)
    
    /// Post a notification
    /// - Parameters:
    ///   - name: notification method name of `NSNotification.Name` type
    ///   - userInfo: optional object to send with the notification of `[AnyHashable: Any]` type.  default value is `nil`
    ///
    /// Usage:
    ///
    ///     OYEvent.post(name: Notification.Name(rawValue: "Method_Name"), userInfo: ["Key": "Value"])
    static func post(name: NSNotification.Name, userInfo: [AnyHashable: Any]?)
}

public final class OYEvent: OYEventProtocol {    
    public static var bag = [Int: [OYObserverable]]()

    /// Add an observer for a notification and observe with notification name of `String` type
    public static func observe(target: AnyObject,
                               name: String,
                               on queue: OperationQueue? = nil,
                               completion: Completable?) {
        observe(target: target, name: Notification.Name(rawValue: name), on: queue, completion: completion)
    }
    
    /// Add an observer for a notification and observe with notification name of `NSNotification.Name` type
    public static func observe(target: AnyObject,
                               name: NSNotification.Name,
                               on queue: OperationQueue? = nil,
                               completion: Completable?) {
        let id = Int(bitPattern: ObjectIdentifier(target))

        if !isEventRegistered(id: id, name: name.rawValue) {
            let observer = NotificationCenter.default.addObserver(forName: name, object: nil, queue: queue) { notification in
                completion?(notification)
            }

            registerEvent(id: id, name: name.rawValue, observer: observer)
        }
    }
    
    /// Post a notification with notification name of `String` type
    public static func post(name: String,
                            userInfo: [AnyHashable: Any]? = nil) {
        post(name: Notification.Name(rawValue: name), userInfo: userInfo)
    }

    /// Post a notification with notification name of `NSNotification.Name` type
    public static func post(name: NSNotification.Name,
                            userInfo: [AnyHashable: Any]? = nil) {
        NotificationCenter.default.post(Notification(name: name, object: nil, userInfo: userInfo))
    }
}

extension OYEvent {
    /// Check that the event is registered (observered) on the AnyObject like UIViewController
    /// - Parameters:
    ///   - id: AnyObject id
    ///   - name: notification method name
    /// - Returns: is registered Bool value
    private static func isEventRegistered(id: Int, name: String) -> Bool {
        Self.bag[id]?.map(\.name).contains(name) ?? false
    }
    
    /// Register event for OYObserverable bag
    /// - Parameters:
    ///   - id: AnyObject id
    ///   - name: notification method name
    ///   - observer: NotificationCenter
    private static func registerEvent(id: Int, name: String, observer: NSObjectProtocol) {
        let event = OYObserverable(name: name, observer: observer)

        guard !(Self.bag[id]?.isEmpty ?? true) else {
            Self.bag[id] = [event]
            return
        }

        Self.bag[id]?.add(event)
    }
}
