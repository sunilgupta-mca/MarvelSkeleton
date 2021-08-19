import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let characterListController = MarvelCharactersListBuilder().build() as? UIViewController else {
            return false
        }
        let navController = BaseNavigationController(rootViewController: characterListController)
        navController.isNavigationBarHidden = false
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
}

