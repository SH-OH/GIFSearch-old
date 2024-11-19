import Swinject
import GlobalThirdPartyLibrary
import GiphyDomainInterface
import SearchFeatureInterface

public final class SearchAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(SearchFactory.self) { r in
            SearchFactoryImpl(
                searchUseCase: r.resolve(SearchUseCase.self)
            )
        }
    }
}
