//
//  Dependency.swift
//  Dependency
//
//  Created by Carl Funk on 10/22/23.
//  Copyright © 2023 Carl Funk. All rights reserved.
//

import Foundation

@propertyWrapper
public struct Dependency<DependencyItem> {
    private let dependencyType: DependencyItem.Type

    public var wrappedValue: DependencyItem {
        guard let dependency = DependencyContainer.shared.obtain(type: dependencyType) else {
            fatalError("Dependency \"\(DependencyItem.self)\" not found.")
        }
        return dependency
    }

    public init(_ dependencyType: DependencyItem.Type) {
        self.dependencyType = dependencyType
    }
}
