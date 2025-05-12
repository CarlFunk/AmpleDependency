# AmpleDependency

A lightweight dependency injection container for Swift, compatible with iOS 16+.

## Features

* Minimalistic and easy-to-use API
* Property wrapper-based injection
* Support for singleton and ephemeral lifecycles
* Thread-safe resolution
* iOS 16+ compatible

## Installation

### Swift Package Manager

To integrate `AmpleDependency` into your Xcode project using Swift Package Manager:

1. Open your project in Xcode.

2. Navigate to **File > Add Packages...**

3. Enter the repository URL:

   ```swift
   https://github.com/CarlFunk/AmpleDependency
   ```

4. Select the appropriate version and add the package to your project.

## Getting Started

### Registering Dependencies

Register your services or objects with the container:

```swift
DependencyContainer.shared.register(type: ServiceProtocol.self) {
    ServiceImplementation()
}
```

Register with a name for providing multiple implementations with the same type:

```swift
DependencyContainer.shared.register(type: ServiceProtocol.self, name: "A") {
    ServiceImplementationA()
}

DependencyContainer.shared.register(type: ServiceProtocol.self, name: "B") {
    ServiceImplementationB()
}
```

### Resolving Dependencies Manually

Resolve your dependencies with the container:

```swift
let service: ServiceProtocol = DependencyContainer.shared.resolve(type: ServiceProtocol.self, lifetime: .singleton)
```

Provide a name to resolve a specific implementation registered earlier:

```swift
let service: ServiceProtocol = DependencyContainer.shared.resolve(type: ServiceProtocol.self, name: "A", lifetime: .singleton)
```

Dependenices can be resolved with the `.singleton` or `.ephemeral` lifetime.

### Resolving Dependencies via the Property Wrapper

For automatic injection, use the `@Dependency` property wrapper:

```swift
class ViewModel {
    @Dependency var service: ServiceProtocol
}
```

This will automatically resolve the `ServiceProtocol` implementation registered in the container. 

IMPORTANT: The default lifetime applied when using the property wrapper is `.singleton`.

The `name:` & `lifetime:` properties can also be used through the property wrapper:

```swift
class ViewModel {
    @Dependency(name: "A", lifetime: .ephemeral) var service: ServiceProtocol
}
```

## Advanced Usage

### Registering with Arguments

If your service requires initialization parameters:

```swift
DependencyContainer.shared.register(type: ServiceProtocol.self) {
    ServiceImplementation(config: Config())
}
```

### Custom Container

Create your own container instance and manage its lifecycle:

```swift
let container = DependencyContainer()

container.register(type: ServiceProtocol.self) {
    ServiceImplementation()
}

container.resolve(type: ServiceProtocol.self, lifetime: .singleton)
```

Use the container instance within the property wrapper to resolve dependencies:

```swift
@Dependency(container: container) var service: ServiceProtocol
```

### Removing Registrations

To clear all registrations:

```swift
DependencyContainer.shared.reset()
```

## Thread Safety

The `DependencyContainer` is thread-safe, ensuring that registrations and resolutions can occur across different threads without issues.


## Requirements

* iOS 16.0+
* Swift 5.7+

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
