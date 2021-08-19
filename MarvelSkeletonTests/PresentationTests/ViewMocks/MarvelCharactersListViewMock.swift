@testable import MarvelSkeleton

final class MarvelCharactersListViewMock: MarvelCharactersListView {
    var presenter: MarvelCharactersListPresenterProtocol!
    var state: MarvelCharactersListViewState?

    func changeViewState(_ state: MarvelCharactersListViewState) {
        self.state = state
    }
}
