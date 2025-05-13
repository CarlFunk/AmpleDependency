//
//  StagingService.swift
//  AmpleDependencyTests
//
//  Created by Carl Funk on 5/11/25.
//  Copyright © 2025 Carl Funk. All rights reserved.
//

import Foundation

final class StagingService: Servicing {
    static let name: String = "STAGING"
    
    let id: String = UUID().uuidString
    
    var name: String {
        Self.name
    }
}
