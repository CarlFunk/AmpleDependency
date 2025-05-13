//
//  DependencyPropertyWrapperTests.swift
//  AmpleDependencyTests
//
//  Created by Carl Funk on 5/11/25.
//  Copyright © 2025 Carl Funk. All rights reserved.
//

@testable import AmpleDependency
import Testing

struct DependencyPropertyWrapperTests {
    let container: DependencyContainer
    
    init() {
        container = DependencyContainer()
        container.register(
            type: Servicing.self
        ) {
            LiveService()
        }
        
        container.register(
            type: Servicing.self,
            name: MockService.name
        ) {
            MockService()
        }
        
        container.register(
            type: Servicing.self,
            name: StagingService.name
        ) {
            StagingService()
        }
    }
    
    @Test
    func defaultName() async throws {
        @Dependency(container: container) var service: any Servicing
        
        #expect(service.name == LiveService.name)
    }
    
    @Test
    func emptyName() async throws {
        @Dependency(name: nil, container: container) var service: any Servicing
        
        #expect(service.name == LiveService.name)
    }

    @Test
    func withName() async throws {
        @Dependency(name: MockService.name, container: container) var mockService: any Servicing
        @Dependency(name: StagingService.name, container: container) var stagingService: any Servicing
        
        #expect(mockService.name == MockService.name)
        #expect(stagingService.name == StagingService.name)
    }
    
    @Test
    func defaultLifetimeIsSingleton() async throws {
        @Dependency(container: container) var service1: any Servicing
        @Dependency(container: container) var service2: any Servicing
        
        #expect(service1 === service2)
        #expect(service1.id == service2.id)
    }
    
    @Test
    func singletonLifetime() async throws {
        @Dependency(lifetime: .singleton, container: container) var service1: any Servicing
        @Dependency(lifetime: .singleton, container: container) var service2: any Servicing
        
        #expect(service1 === service2)
        #expect(service1.id == service2.id)
    }
    
    @Test
    func ephemeralLifetime() async throws {
        @Dependency(lifetime: .ephemeral, container: container) var service1: any Servicing
        @Dependency(lifetime: .ephemeral, container: container) var service2: any Servicing
        
        #expect(service1 !== service2)
        #expect(service1.id != service2.id)
    }
    
    @Test
    func defaultContainer() async throws {
        DependencyContainer.shared.register(type: Servicing.self) {
            StagingService()
        }
        
        @Dependency var service: any Servicing
        
        #expect(service.name == StagingService.name)
    }
    
    @Test
    func setter() async throws {
        @Dependency(container: container) var service1: any Servicing
        service1 = MockService()
        @Dependency(container: container) var service2: any Servicing
        
        #expect(service1 !== service2)
        #expect(service1.id != service2.id)
        #expect(service1.name == MockService.name)
        #expect(service2.name == LiveService.name)
    }
}
