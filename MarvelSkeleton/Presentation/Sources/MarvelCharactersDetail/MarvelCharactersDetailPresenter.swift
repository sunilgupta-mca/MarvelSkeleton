enum MarvelCharactersDetailViewState: State {
    case clear
    case showLoader
    case render(MarvelCharactersDetailViewModel)
    case showError
}

protocol MarvelCharactersDetailPresenterProtocol: PresenterProtocol {
    var view: MarvelCharactersDetailView? { get set }

    func didTapOnRetryButton()
    func setupCharacterID(characterId: Int32)
}

final class MarvelCharactersDetailPresenter: MarvelCharactersDetailPresenterProtocol {
    var marvelCharactersDetailUseCase: GetMarvelCharactersDetailUseCaseProtocol
    weak var view: MarvelCharactersDetailView?
    var characterId: Int32?

    private var viewState: MarvelCharactersDetailViewState = .clear {
        didSet {
            guard oldValue != viewState else {
                return
            }
            view?.changeViewState(viewState)
        }
    }

    init(marvelCharactersDetailUseCase: GetMarvelCharactersDetailUseCaseProtocol) {
        self.marvelCharactersDetailUseCase = marvelCharactersDetailUseCase
    }

    func setupCharacterID(characterId: Int32) {
        self.characterId = characterId
    }

    func viewWillAppear() {
        fetchMarvelCharactersDetail(selectedId: characterId ?? 0)
    }

    func didTapOnRetryButton() {
        fetchMarvelCharactersDetail(selectedId: characterId ?? 0)
    }
}

private extension MarvelCharactersDetailPresenter {
    func fetchMarvelCharactersDetail(selectedId: Int32) {
        viewState = .showLoader
        let param = MarvelCharactersDetailParams(characterId: selectedId) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(model):
                let viewModel = model.mapDomainToViewModel()
                self.viewState = .render(viewModel)
            case .failure(_):
                self.viewState = .showError
            }
        }
        marvelCharactersDetailUseCase.execute(param)
    }
}
