//
//  DependencyContaining.swift
//  AmpleDependency
//
//  Created by Carl Funk on 10/22/23.
//  Copyright © 2023 Carl Funk. All rights reserved.
//

import Foundation

public protocol DependencyContaining {
    func register<Dependency>(
        type: Dependency.Type,
        name: String?,
        factory: @escaping () -> Dependency
    )
    
    func resolve<Dependency>(
        type: Dependency.Type,
        name: String?,
        lifetime: DependencyLifetime
    ) throws -> Dependency
    
    func reset()
}

public extension DependencyContaining {
    func register<Dependency>(
        type: Dependency.Type,
        factory: @escaping () -> Dependency
    ) {
        register(type: type, name: nil, factory: factory)
    }
    
    func resolve<Dependency>(
        type: Dependency.Type,
        lifetime: DependencyLifetime
    ) throws -> Dependency {
        try resolve(type: type, name: nil, lifetime: lifetime)
    }
}
