import UIKit
import SwiftCoordinator

final class AppCoordinator: PresentationCoordinator {
    
    var childCoordinators: [Coordinator] = []
    var rootViewController = TabBarViewController()

    init(window: UIWindow) {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }

    func start() {
    }
}
