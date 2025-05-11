//
//  DependencyContainer.swift
//  Dependency
//
//  Created by Carl Funk on 10/22/23.
//  Copyright © 2023 Carl Funk. All rights reserved.
//

import Foundation

public final class DependencyContainer: DependencyContaining {
    // TODO: Ensure thread safety of registration / resolution
    nonisolated(unsafe) public static let shared: DependencyContaining = DependencyContainer()
    
    internal var factories: [DependencyKey: () -> Any] = [:]
    internal var singletons: [DependencyKey: Any] = [:]
    
    public init() {}
    
    public func register<Dependency>(
        type: Dependency.Type,
        name: String?,
        factory: @escaping () -> Dependency
    ) {
        let key = DependencyKey(type: type, name: name)
        factories[key] = factory
    }
    
    public func resolve<Dependency>(
        type: Dependency.Type,
        name: String?,
        lifetime: DependencyLifetime
    ) throws -> Dependency {
        let key = DependencyKey(type: type, name: name)
        guard let factory = factories[key] else {
            throw DependencyError.missingRegistration(type: type, name: name)
        }
        
        switch lifetime {
        case .singleton:
            guard let existingInstance = singletons[key] as? Dependency else {
                let newInstance = factory() as! Dependency
                singletons[key] = newInstance
                return newInstance
            }
            return existingInstance
        case .ephemeral:
            let newInstance = factory() as! Dependency
            return newInstance
        }
    }
    
    public func reset() {
        factories.removeAll()
        singletons.removeAll()
    }
}
