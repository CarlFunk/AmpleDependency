//
//  DependencyKeyTests.swift
//  DependencyTests
//
//  Created by Carl Funk on 5/11/25.
//  Copyright © 2025 Carl Funk. All rights reserved.
//

@testable import Dependency
import Testing

struct DependencyKeyTests {
    @Test
    func initializer() async throws {
        let key = DependencyKey(type: Servicing.self, name: LiveService.name)
        
        #expect(key.typeName == String(describing: Servicing.self))
        #expect(key.name == LiveService.name)
    }
    
    @Test
    func hashIncludesTypeAndName() async throws {
        let key = DependencyKey(type: Servicing.self, name: LiveService.name)
        
        var hasher = Hasher()
        hasher.combine(String(describing: Servicing.self))
        hasher.combine(Optional<String>(LiveService.name))
        let hashValue = hasher.finalize()
        
        #expect(key.hashValue == hashValue)
    }
}
