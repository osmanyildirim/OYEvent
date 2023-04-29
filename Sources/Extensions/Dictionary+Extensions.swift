//
//  Dictionary+Extensions.swift
//  OYEvent
//
//  Created by osmanyildirim
//

import Foundation

extension Dictionary {
    /// var dict = ["Key1": "Value1", "Key2": "Value2", "Key3": "Value3"]
    /// `dict.allValues` → output  → ["Value1", "Value2", "Value3"]
    var allValues: [Value] {
        values.compactMap({ $0 })
    }

    /// var dict = ["Key1": "Value1", "Key2": "Value2", "Key3": "Value3"]
    /// `dict.remove(keys: ["Key1", "Key2"])` → output → ["Key3": "Value3"]
    mutating func remove(keys: Key...) {
        keys.forEach { removeValue(forKey: $0) }
    }

    /// var dict = ["Key1":  ["Value1", "Value2"]]
    /// `dict.removeValue(key: "Key1", value: "Value2")` → output → ["Key1":  ["Value1"]]
    mutating func removeValue<T: Equatable>(key: Key, value: T) where Value == [T] {
        self[key]?.removeAll(where: { $0 == value })
    }
}
