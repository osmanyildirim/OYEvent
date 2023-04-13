//
//  OYDisposable.swift
//  OYEvent
//
//  Created by osmanyildirim
//

import Foundation

public protocol OYDisposable {
    /// Dispose NotificationCenter observer with notification method name
    /// - Parameters:
    ///   - name: notification method name of `String` type
    /// Usage:
    ///
    ///     OYEvent.dispose(name: "Method_Name")
    static func dispose(name: String)
    
    /// Dispose NotificationCenter observer with notification method name
    /// - Parameters:
    ///   - name: notification method name of `NSNotification.Name` type
    /// Usage:
    ///
    ///     OYEvent.dispose(name: Notification.Name(rawValue: "Method_Name"))
    static func dispose(name: NSNotification.Name)

    
    /// Dispose NotificationCenter observer with target and notification method name
    /// - Parameters:
    ///   - target: AnyObject instance, e.g. `UIViewController`
    ///   - name: notification method name of `String` type
    ///
    /// Usage:
    ///
    ///     OYEvent.dispose(target: self, name: "Method_Name")
    static func dispose(target: AnyObject, name: String)
    
    /// Dispose NotificationCenter observer with target and notification name
    /// - Parameters:
    ///   - target: AnyObject instance, e.g. `UIViewController`
    ///   - name: notification method name of `NSNotification.Name` type
    ///
    /// Usage:
    ///
    ///     OYEvent.dispose(target: self, name: Notification.Name(rawValue: "Method_Name"))
    static func dispose(target: AnyObject, name: NSNotification.Name)
    
    /// Dispose all NotificationCenter observers with target
    /// - Parameters:
    ///   - on: AnyObject instance, e.g. `UIViewController`
    ///
    /// Usage:
    ///
    ///     OYEvent.disposeAll(target: self)
    static func disposeAll(target: AnyObject)
    
    /// Dispose all NotificationCenter observers defined anywhere
    ///
    /// Usage:
    ///
    ///     OYEvent.disposeAll()
    static func disposeAll()
}

extension OYDisposable where Self == OYEvent {
    /// Dispose NotificationCenter observer with notification method name
    public static func dispose(name: String) {
        dispose(name: NSNotification.Name(name))
    }
    
    /// Dispose NotificationCente observerr with notification method name
    public static func dispose(name: NSNotification.Name) {
        let bag = Self.bag

        for (key, value) in bag {
            guard let observerable = value.first(where: { $0.name == name.rawValue }) else { continue }
            NotificationCenter.default.removeObserver(observerable.observer, name: Notification.Name(rawValue: name.rawValue), object: nil)

            if value.count == 1 {
                Self.bag.remove(keys: key)
            } else {
                Self.bag.removeValue(key: key, value: observerable)
            }
        }
    }
    
    /// Dispose NotificationCenter observer with target and notification method name
    public static func dispose(target: AnyObject, name: String) {
        dispose(target: target, name: NSNotification.Name(name))
    }

    /// Dispose NotificationCenter observer with target and notification name
    public static func dispose(target: AnyObject, name: NSNotification.Name) {
        let id = Int(bitPattern: ObjectIdentifier(target))
        guard let event = Self.bag[id]?.first(where: { $0[keyPath: \.name] == name.rawValue }) else { return }
        NotificationCenter.default.removeObserver(event.observer, name: Notification.Name(rawValue: event.name), object: nil)
    }

    /// Dispose all NotificationCenter observers with target
    public static func disposeAll(target: AnyObject) {
        remove(id: Int(bitPattern: ObjectIdentifier(target)))
    }

    /// Dispose all NotificationCenter observers defined anywhere
    public static func disposeAll() {
        Self.bag.forEach({ remove(id: $0.key) })
    }
}

extension OYDisposable where Self == OYEvent {
    /// Remove NotificationCenter observer
    private static func remove(id: Int) {
        let observer = Self.bag[id]
        let removeClosure = { (observers: OYObserverable) in
            NotificationCenter.default.removeObserver(observers.observer)
        }
        observer?.forEach(removeClosure)
        Self.bag[id] = nil
    }
}
