//
//  DependencyKey.swift
//  Dependency
//
//  Created by Carl Funk on 5/10/25.
//  Copyright © 2025 Carl Funk. All rights reserved.
//

import Foundation

internal struct DependencyKey: Hashable {
    internal let typeName: String
    internal let name: String?
    
    internal init<Dependency>(type: Dependency.Type, name: String? = nil) {
        self.typeName = String(describing: type)
        self.name = name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(typeName)
        hasher.combine(name)
    }
}
