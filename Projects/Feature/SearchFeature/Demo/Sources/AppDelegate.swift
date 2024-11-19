import UIKit
@testable import GiphyDomainTesting
@testable import SearchFeature

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let useCase = SearchUseCaseSpy()
        useCase.callAsFunctionReturn = .init(totalCount: 2, models: [
            .init(height: 200, width: 200, size: 10, url: "https://media4.giphy.com/media/oAm6GxEYV1EVcJRyyO/200w.gif?cid=72ae528futhwqg16zj58yf3porlzpxlz21u2ooobpoo7edla&ep=v1_gifs_trending&rid=200w.gif&ct=g".url),
            .init(height: 200, width: 200, size: 20, url: "https://media1.giphy.com/media/nol639YPJbRdY1RxCN/200w.gif?cid=72ae528f715gdfzcmb4vx0sr78h1qyeqa64nlkmwrruly4o0&ep=v1_gifs_trending&rid=200w.gif&ct=g".url)
        ])
        let viewController = SearchFactoryImpl(searchUseCase: useCase).makeViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        return true
    }
}
