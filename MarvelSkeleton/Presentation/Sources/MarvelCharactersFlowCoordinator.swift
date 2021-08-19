import UIKit

protocol MarvelCharactersFlowCoordinatorProtocol {
    func goToCharactersDetailScreen(characterId: Int32)
}

final class MarvelCharactersFlowCoordinator: MarvelCharactersFlowCoordinatorProtocol {
    func goToCharactersDetailScreen(characterId: Int32) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let navigationController = appDelegate.window?.rootViewController as? UINavigationController,
              let detailViewController = MarvelCharactersDetailBuilder().build(characterId: characterId) as? UIViewController else {
            return
        }
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
