//
//  DependencyContaining.swift
//  Dependency
//
//  Created by Carl Funk on 10/22/23.
//  Copyright © 2023 Carl Funk. All rights reserved.
//

import Foundation

public protocol DependencyContaining {
    func register<DependencyItem>(type: DependencyItem.Type, item: Any)
    func obtain<DependencyItem>(type: DependencyItem.Type) -> DependencyItem?
}
