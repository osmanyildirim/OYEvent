//
//  OYObserverable+Extensions.swift
//  OYEvent
//
//  Created by osmanyildirim
//

import Foundation

extension [OYObserverable] {
    /// add OYObserverable to static bag
    /// - Parameter item: OYObserverable item
    mutating func add(_ item: OYObserverable) {
        guard !contains(where: { $0[keyPath: \.name] == item.name }) else { return }
        append(item)
    }
}
