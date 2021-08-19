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
    func didTableViewScrolledToBottom()
}

final class MarvelCharactersListPresenter: MarvelCharactersListPresenterProtocol {
    var marvelCharactersUseCase: GetMarvelCharactersListUseCaseProtocol
    weak var view: MarvelCharactersListView?
    var marvelCharactersFlowCoordinatorProtocol: MarvelCharactersFlowCoordinatorProtocol?
    var marvelCharactersModel = [MarvelCharactersResultsModel]()
    private var isLoadingNextPage = false
    private var isAllRecordFetched = false
    private var currentOffset = 0

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

    func didTableViewScrolledToBottom() {
        if !isLoadingNextPage && !isAllRecordFetched {
            fetchNewRecords()
        }
    }
}

private extension MarvelCharactersListPresenter {
    func fetchMarvelCharactersList() {
        viewState = currentOffset == 0 ? .showLoader : .clear
        isLoadingNextPage = true
        let param = MarvelCharactersListParams(currentOffset: Int32(currentOffset)) { [weak self] result in
            guard let self = self else {
                return
            }
            self.isLoadingNextPage = false
            switch result {
            case let .success(model):
                self.responseReceived(model: model)
                self.viewState = .renderData
            case .failure(_):
                self.viewState = .showError
            }
        }
        marvelCharactersUseCase.execute(param)
    }

    func responseReceived(model: MarvelCharactersModel) {
        guard let results = model.data?.results else {
            return
        }
        currentOffset += results.count
        let limit = model.data?.limit ?? 0
        let count = model.data?.count ?? 0
        isAllRecordFetched = count < limit
        marvelCharactersModel.append(contentsOf: results)
    }

    func fetchNewRecords() {
        fetchMarvelCharactersList()
    }
}
