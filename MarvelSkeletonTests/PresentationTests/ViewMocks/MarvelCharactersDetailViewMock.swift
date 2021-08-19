@testable import MarvelSkeleton

final class MarvelCharactersDetailViewMock: MarvelCharactersDetailView {
    var presenter: MarvelCharactersDetailPresenterProtocol!
    var state: MarvelCharactersDetailViewState?

    func changeViewState(_ state: MarvelCharactersDetailViewState) {
        self.state = state
    }
}
