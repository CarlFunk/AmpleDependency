//
//  DependencyContainer.swift
//  Dependency
//
//  Created by Carl Funk on 10/22/23.
//  Copyright © 2023 Carl Funk. All rights reserved.
//

public final class DependencyContainer: DependencyContaining {
    public static let shared: DependencyContaining = DependencyContainer()
    
    private var container: [String: Any] = [:]
    
    private init() { }
    
    public func register<DependencyItem>(type: DependencyItem.Type, item: Any) {
        container[String(describing: type)] = item
    }
    
    public func obtain<DependencyItem>(type: DependencyItem.Type) -> DependencyItem? {
        container[String(describing: type)] as? DependencyItem
    }
}
