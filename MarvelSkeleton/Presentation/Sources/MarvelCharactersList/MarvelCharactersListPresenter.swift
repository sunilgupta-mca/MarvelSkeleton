enum MarvelCharactersListViewState: State {
    case clear
    case showLoader
    case renderData
    case showError
}

protocol MarvelCharactersListPresenterProtocol: PresenterProtocol {
    var view: MarvelCharactersListView? { get set }
    var marvelCharactersFlowCoordinatorProtocol: MarvelCharactersFlowCoordinatorProtocol? { get set }

    func didTapOnRetryButton()
    func didTapOnTableRow(row: Int)
    func numberOfRowsForTableView() -> Int
    func viewModelForRow(row: Int) -> MarvelCharactersViewModel?
}

final class MarvelCharactersListPresenter: MarvelCharactersListPresenterProtocol {
    var marvelCharactersUseCase: GetMarvelCharactersListUseCaseProtocol
    weak var view: MarvelCharactersListView?
    var marvelCharactersFlowCoordinatorProtocol: MarvelCharactersFlowCoordinatorProtocol?
    var marvelCharactersModel = [MarvelCharactersResultsModel]()

    private var viewState: MarvelCharactersListViewState = .clear {
        didSet {
            guard oldValue != viewState else {
                return
            }
            view?.changeViewState(viewState)
        }
    }

    init(marvelCharactersListUseCase: GetMarvelCharactersListUseCaseProtocol) {
        self.marvelCharactersUseCase = marvelCharactersListUseCase
    }

    func viewWillAppear() {
        if marvelCharactersModel.isEmpty {
            fetchMarvelCharactersList()
        }
    }

    func didTapOnRetryButton() {
        fetchMarvelCharactersList()
    }

    func didTapOnTableRow(row: Int) {
        if marvelCharactersModel.count > row {
            let viewModel = marvelCharactersModel[row]
            marvelCharactersFlowCoordinatorProtocol?.goToCharactersDetailScreen(characterId: viewModel.id)
        }
    }

    func numberOfRowsForTableView() -> Int {
        return marvelCharactersModel.count
    }

    func viewModelForRow(row: Int) -> MarvelCharactersViewModel? {
        if marvelCharactersModel.count > row {
            let result = marvelCharactersModel[row]
            let viewModel = result.mapDomainToViewModel()
            return viewModel
        }
        return nil
    }
}

private extension MarvelCharactersListPresenter {
    func fetchMarvelCharactersList() {
        viewState = .showLoader
        marvelCharactersUseCase.execute { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(model):
                self.responseReceived(model: model)
                self.viewState = .renderData
            case .failure(_):
                self.viewState = .showError
            }
        }
    }

    func responseReceived(model: MarvelCharactersModel) {
        guard let results = model.data?.results else {
            return
        }
        marvelCharactersModel.removeAll()
        marvelCharactersModel.append(contentsOf: results)
    }
}
