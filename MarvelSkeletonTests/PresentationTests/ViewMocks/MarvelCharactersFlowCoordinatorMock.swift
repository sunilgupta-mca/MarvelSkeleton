@testable import MarvelSkeleton

final class MarvelCharactersFlowCoordinatorMock: MarvelCharactersFlowCoordinatorProtocol {
    var isDetailNavigationCalled = false

    func goToCharactersDetailScreen(characterId: Int32) {
        isDetailNavigationCalled = true
    }
}
