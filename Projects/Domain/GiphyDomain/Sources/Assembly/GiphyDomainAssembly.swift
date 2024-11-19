import Swinject
import GlobalThirdPartyLibrary
import GiphyDomainInterface
import NetworkingInterface

public final class GiphyDomainAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(GiphyRepository.self) { r in
            GiphyRepositoryImpl(
                networking: r.resolve(Networking.self)
            )
        }
        .inObjectScope(.container)
        
        container.register(TrendingUseCase.self) { r in
            TrendingUseCaseImpl(
                giphyRepository: r.resolve(GiphyRepository.self)
            )
        }
        
        container.register(SearchUseCase.self) { r in
            SearchUseCaseImpl(
                giphyRepository: r.resolve(GiphyRepository.self)
            )
        }
    }
}
