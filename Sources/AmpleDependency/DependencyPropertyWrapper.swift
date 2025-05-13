//
//  Dependency.swift
//  AmpleDependency
//
//  Created by Carl Funk on 10/22/23.
//  Copyright © 2023 Carl Funk. All rights reserved.
//

import Foundation

@propertyWrapper
public struct Dependency<Dependency> {
    private var dependency: Dependency
    
    public var wrappedValue: Dependency {
        get {
            dependency
        }
        set {
            dependency = newValue
        }
    }
    
    public init(
        name: String? = nil,
        lifetime: DependencyLifetime = .singleton,
        container: DependencyContaining = DependencyContainer.shared
    ) {
        do {
            dependency = try container.resolve(
                type: Dependency.self,
                name: name,
                lifetime: lifetime)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
