import Swinject
import GlobalThirdPartyLibrary
import GiphyDomainInterface
import HomeFeatureInterface

public final class HomeAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(HomeFactory.self) { r in
            HomeFactoryImpl(
                trendingUseCase: r.resolve(TrendingUseCase.self)
            )
        }
    }
}
