//
//  DependencyContainer.swift
//  AmpleDependency
//
//  Created by Carl Funk on 10/22/23.
//  Copyright © 2023 Carl Funk. All rights reserved.
//

import Foundation

public final class DependencyContainer: DependencyContaining {
    nonisolated(unsafe) public static let shared: DependencyContaining = DependencyContainer()
    
    internal var factories: [DependencyKey: () -> Any] = [:]
    internal var singletons: [DependencyKey: Any] = [:]
    
    private let lock = NSLock()
    
    public init() {}
    
    public func register<Dependency>(
        type: Dependency.Type,
        name: String?,
        factory: @escaping () -> Dependency
    ) {
        let key = DependencyKey(type: type, name: name)
        setFactory(factory, for: key)
    }
    
    public func resolve<Dependency>(
        type: Dependency.Type,
        name: String?,
        lifetime: DependencyLifetime
    ) throws -> Dependency {
        let key = DependencyKey(type: type, name: name)
        guard let factory = getFactory(for: key) else {
            throw DependencyError.missingRegistration(type: type, name: name)
        }
        
        switch lifetime {
        case .singleton:
            guard let existingInstance = getSingleton(for: key) as? Dependency else {
                let newInstance = factory() as! Dependency
                setSingleton(newInstance, for: key)
                return newInstance
            }
            return existingInstance
        case .ephemeral:
            let newInstance = factory() as! Dependency
            return newInstance
        }
    }
    
    public func reset() {
        lock.lock()
        factories.removeAll()
        singletons.removeAll()
        lock.unlock()
    }
    
    // MARK: - Private
    
    private func getFactory(for key: DependencyKey) -> (() -> Any)? {
        lock.withLock {
            factories[key]
        }
    }
    
    private func setFactory(_ factory: @escaping () -> Any, for key: DependencyKey) {
        lock.lock()
        factories[key] = factory
        lock.unlock()
    }
    
    private func getSingleton(for key: DependencyKey) -> Any? {
        lock.withLock {
            singletons[key]
        }
    }
    
    private func setSingleton(_ instance: Any, for key: DependencyKey) {
        lock.lock()
        singletons[key] = instance
        lock.unlock()
    }
}
