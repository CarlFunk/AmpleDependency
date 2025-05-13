//
//  DependencyContainerTests.swift
//  AmpleDependencyTests
//
//  Created by Carl Funk on 5/11/25.
//  Copyright © 2025 Carl Funk. All rights reserved.
//

@testable import AmpleDependency
import Testing

struct DependencyContainerTests {
    let container: DependencyContainer
    
    init() {
        container = DependencyContainer()
    }
    
    @Test
    func registerWithoutName() async throws {
        #expect(container.factories.isEmpty)
        
        container.register(type: Servicing.self) {
            LiveService()
        }
        
        #expect(container.factories.count == 1)
    }
    
    @Test
    func registerWithName() async throws {
        #expect(container.factories.isEmpty)
        
        container.register(type: Servicing.self, name: MockService.name) {
            MockService()
        }
        
        #expect(container.factories.count == 1)
    }
    
    @Test
    func resolveWithoutRegistration() async throws {
        do {
            let _ = try container.resolve(type: Servicing.self, lifetime: .singleton)
        } catch {
            if case DependencyError.missingRegistration = error {
                #expect(error.localizedDescription == "No registration found for Servicing with name nil")
            }
        }
    }
    class Parent {
        init() { }
    }
    
    class Child: Parent {
        override init() {
            
        }
    }
    
    @Test
    func resolveWithoutName() async throws {
        container.register(type: Servicing.self) {
            LiveService()
        }
        
        let service = try! container.resolve(type: Servicing.self, lifetime: .singleton)
        
        #expect(service.name == LiveService.name)
    }
    
    @Test
    func resolveWithName() async throws {
        container.register(type: Servicing.self, name: MockService.name) {
            MockService()
        }
        
        let mockService = try! container.resolve(type: Servicing.self, name: MockService.name, lifetime: .singleton)
        
        #expect(mockService.name == MockService.name)
    }
    
    @Test
    func reset() async throws {
        container.register(type: Servicing.self) {
            LiveService()
        }
        
        let _ = try! container.resolve(type: Servicing.self, lifetime: .singleton)
        
        #expect(container.factories.count == 1)
        #expect(container.singletons.count == 1)
        
        container.reset()
        
        #expect(container.factories.isEmpty)
        #expect(container.singletons.isEmpty)
    }
}
