final class MarvelCharactersListBuilder {
    var view: MarvelCharactersListView = MarvelCharactersListViewController.instantiate()
    var presenter: MarvelCharactersListPresenterProtocol = MarvelCharactersListPresenter(marvelCharactersListUseCase:  DependencyManager.getMarvelCharactersListUseCase())
    var marvelCharactersFlowCoordinator = MarvelCharactersFlowCoordinator()

    func build() -> MarvelCharactersListView {
        presenter.view = view
        presenter.marvelCharactersFlowCoordinatorProtocol = marvelCharactersFlowCoordinator
        view.presenter = presenter
        return view
    }
}
