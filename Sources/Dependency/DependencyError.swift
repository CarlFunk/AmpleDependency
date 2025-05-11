//
//  DependencyError.swift
//  Dependency
//
//  Created by Carl Funk on 5/11/25.
//  Copyright © 2025 Carl Funk. All rights reserved.
//

import Foundation

public enum DependencyError: LocalizedError {
    case missingRegistration(type: Any.Type, name: String?)
    
    public var errorDescription: String? {
        switch self {
        case .missingRegistration(let type, let name):
            "No registration found for \(type) with name \(name ?? "nil")"
        }
    }
}
