//
//  OYObserverable.swift
//  OYEvent
//
//  Created by osmanyildirim
//

import Foundation

public struct OYObserverable: Equatable {
    /// Method name of NotificationCenter observer
    let name: String
    
    /// NotificationCenter observer
    let observer: NSObjectProtocol

    public static func == (lhs: OYObserverable, rhs: OYObserverable) -> Bool {
        lhs.name == rhs.name
    }
}
