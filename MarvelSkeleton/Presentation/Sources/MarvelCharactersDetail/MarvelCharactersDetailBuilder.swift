final class MarvelCharactersDetailBuilder {
    let view: MarvelCharactersDetailView = MarvelCharactersDetailViewController.instantiate()
    let presenter: MarvelCharactersDetailPresenterProtocol = MarvelCharactersDetailPresenter(marvelCharactersDetailUseCase:DependencyManager.getMarvelCharactersDetailUseCase())

    func build(characterId: Int32) -> MarvelCharactersDetailView {
        presenter.view = view
        presenter.setupCharacterID(characterId: characterId)
        view.presenter = presenter
        return view
    }
}
