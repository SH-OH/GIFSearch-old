import Swinject
import NetworkingInterface

public final class NetworkingAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(Networking.self) { _ in
            NetworkingImpl()
        }
    }
}
