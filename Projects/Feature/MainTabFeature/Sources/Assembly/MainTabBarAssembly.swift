import Swinject
import GlobalThirdPartyLibrary
import HomeFeatureInterface
import SearchFeatureInterface
import MainTabFeatureInterface

public final class MainTabBarAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(MainTabBarFactory.self) { r in
            MainTabBarFactoryImpl(
                homeFactory: r.resolve(HomeFactory.self),
                searchFactory: r.resolve(SearchFactory.self)
            )
        }
    }
}
