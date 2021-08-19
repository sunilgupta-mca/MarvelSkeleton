@testable import MarvelSkeleton
import XCTest

class MarvelCharactersListPresenterTests: XCTestCase {
    var presenter: MarvelCharactersListPresenter!
    var mockView: MarvelCharactersListViewMock!
    var marvelCharactersUseCase: GetMarvelCharactersListUseCaseProtocol = DependencyManager.getMarvelCharactersListUseCase()
    var mockMarvelCharactersListUseCase = MarvelCharactersListUseCaseMock()
    var marvelCharactersFlowCoordinatorMock = MarvelCharactersFlowCoordinatorMock()

    override func setUp() {
        super.setUp()
        presenter = MarvelCharactersListPresenter(marvelCharactersListUseCase: mockMarvelCharactersListUseCase)
        mockView = MarvelCharactersListViewMock()
        presenter.view = mockView
        presenter.marvelCharactersFlowCoordinatorProtocol = marvelCharactersFlowCoordinatorMock
        mockView.presenter = presenter
    }

    override class func tearDown() {
        super.tearDown()
    }

    func testFetchMarvelCharactersListSuccess() {
        //Given
        mockMarvelCharactersListUseCase.result = .success(getMarvelCharactersModel())

        //When
        presenter.viewWillAppear()

        //Then
        XCTAssertEqual(presenter.marvelCharactersModel.count, 1)
    }

    func testFetchMarvelCharactersListFailure() {
        //Given
        let error = NSError(domain: NSURLErrorDomain, code: 0, userInfo: nil)
        mockMarvelCharactersListUseCase.result = .failure(.network(.general(error)))

        //When
        presenter.viewWillAppear()

        //Then
        XCTAssertEqual(mockView.state, .showError)
    }

    func testDidTapOnRetryButton() {
        //Given
        mockMarvelCharactersListUseCase.result = .success(getMarvelCharactersModel())

        //When
        presenter.didTapOnRetryButton()

        //Then
        XCTAssertEqual(presenter.marvelCharactersModel.count, 1)
    }

    func testDidTapOnTableRow() throws {
        //Given
        presenter.marvelCharactersModel = getMarvelCharacterDomainModel(model: getMarvelCharactersModel())

        //When
        presenter.didTapOnTableRow(row: 0)

        //Then
        XCTAssertTrue(marvelCharactersFlowCoordinatorMock.isDetailNavigationCalled)
    }

    func testNumberOfRowsForTableView() {
        //Given
        presenter.marvelCharactersModel = getMarvelCharacterDomainModel(model: getMarvelCharactersModel())

        //When
        let result = presenter.numberOfRowsForTableView()

        //Then
        XCTAssertEqual(result, 1)
    }

    func testViewModelForRowRetunsModel() {
        //Given
        presenter.marvelCharactersModel = getMarvelCharacterDomainModel(model: getMarvelCharactersModel())

        //When
        let model = presenter.viewModelForRow(row: 0)

        //Then
        XCTAssertNotNil(model)
    }

    func testViewModelForRowNotRetunsModel() {
        //Given
        presenter.marvelCharactersModel = []

        //When
        let model = presenter.viewModelForRow(row: 0)

        //Then
        XCTAssertNil(model)
    }

    func testDidTableViewScrolledToBottom() {
        //Given
        mockMarvelCharactersListUseCase.result = .success(getMarvelCharactersModel())

        //When
        presenter.didTableViewScrolledToBottom()

        //Then
        XCTAssertEqual(presenter.marvelCharactersModel.count, 1)
    }
}

private extension MarvelCharactersListPresenterTests {
    func getMarvelCharactersModel() -> MarvelCharactersModel {
        return MarvelCharactersModel(data: getMarvelCharactersDataModel())
    }

    func getMarvelCharactersDataModel() -> MarvelCharactersDataModel {
        return MarvelCharactersDataModel(offset: 0, limit: 10, total: 50, count: 50, results: [getMarvelCharactersResultsModel()])
    }

    func getMarvelCharactersResultsModel() -> MarvelCharactersResultsModel {
        return MarvelCharactersResultsModel(id: 1017265,
                                            name: "Thor",
                                            thumbnail: getMarvelCharacterImageModel(),
                                            description: "description",
                                            comics: MarvelCharactersAvailablityCountModel(available: 2),
                                            series: MarvelCharactersAvailablityCountModel(available: 3),
                                            stories: MarvelCharactersAvailablityCountModel(available: 4),
                                            events: MarvelCharactersAvailablityCountModel(available: 5))
    }

    func getMarvelCharacterImageModel() -> MarvelCharacterImageModel {
        let imagePath = "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784"
        return MarvelCharacterImageModel(path: imagePath, imageExtension: "jpg")
    }

    func getMarvelCharacterDomainModel(model: MarvelCharactersModel)
    -> [MarvelCharactersResultsModel] {
        guard let results = model.data?.results else {
            return []
        }
        return results
    }
}
