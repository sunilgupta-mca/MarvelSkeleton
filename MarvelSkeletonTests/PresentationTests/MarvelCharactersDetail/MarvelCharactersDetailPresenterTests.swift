@testable import MarvelSkeleton
import XCTest

class MarvelCharactersDetailPresenterTests: XCTestCase {
    var presenter: MarvelCharactersDetailPresenter!
    var mockView: MarvelCharactersDetailViewMock!
    var marvelCharactersDetailUseCase: GetMarvelCharactersDetailUseCaseProtocol = DependencyManager.getMarvelCharactersDetailUseCase()
    var mockMarvelCharactersDetailUseCase = MarvelCharactersDetailUseCaseMock()

    override func setUp() {
        super.setUp()
        presenter = MarvelCharactersDetailPresenter(marvelCharactersDetailUseCase: mockMarvelCharactersDetailUseCase)
        mockView = MarvelCharactersDetailViewMock()
        presenter.view = mockView
        mockView.presenter = presenter
    }

    override class func tearDown() {
        super.tearDown()
    }

    func testFetchMarvelCharactersDetailSuccess() {
        //Given
        mockMarvelCharactersDetailUseCase.result = .success(getMarvelCharacterDetailModel())

        //When
        presenter.viewWillAppear()

        //Then
        let viewModel = getMarvelCharactersDetailViewModel(model: getMarvelCharacterDetailModel())
        XCTAssertEqual(mockView.state, .render(viewModel))
    }

    func testFetchMarvelCharactersDetailFailure() {
        //Given
        let error = NSError(domain: NSURLErrorDomain, code: 0, userInfo: nil)
        mockMarvelCharactersDetailUseCase.result = .failure(.network(.general(error)))

        //When
        presenter.viewWillAppear()

        //Then
        XCTAssertEqual(mockView.state, .showError)
    }

    func testDidTapOnRetryButton() {
        //Given
        mockMarvelCharactersDetailUseCase.result = .success(getMarvelCharacterDetailModel())

        //When
        presenter.didTapOnRetryButton()

        //Then
        let viewModel = getMarvelCharactersDetailViewModel(model: getMarvelCharacterDetailModel())
        XCTAssertEqual(mockView.state, .render(viewModel))
    }
}

private extension MarvelCharactersDetailPresenterTests {
    func getMarvelCharacterDetailModel() -> MarvelCharacterDetailModel {
        return MarvelCharacterDetailModel(copyright: "© 2021 MARVEL",
                                         data: getMarvelCharactersDataModel())
    }

    func getMarvelCharactersDataModel() -> MarvelCharactersDataModel {
        MarvelCharactersDataModel(offset: 0, limit: 10, total: 50, count: 50, results: [getMarvelCharactersResultsModel()])
    }

    func getMarvelCharactersResultsModel() -> MarvelCharactersResultsModel {
        return MarvelCharactersResultsModel(id: 1017265,
                                            name: "Thor",
                                            thumbnail: getMarvelCharacterImageModel(), description: "description",
                                            comics: MarvelCharactersAvailablityCountModel(available: 2),
                                            series: MarvelCharactersAvailablityCountModel(available: 3),
                                            stories: MarvelCharactersAvailablityCountModel(available: 4),
                                            events: MarvelCharactersAvailablityCountModel(available: 5))
    }

    func getMarvelCharacterImageModel() -> MarvelCharacterImageModel {
        let imagePath = "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784"
        return MarvelCharacterImageModel(path: imagePath, imageExtension: "jpg")
    }

    func getMarvelCharactersDetailViewModel(model: MarvelCharacterDetailModel) -> MarvelCharactersDetailViewModel {
        let viewModel = MarvelCharactersDetailViewModel(name: "Thor",
                                                        copyrightLabel: model.copyright,
                                                        imageUrl: model.data?.results.first?.thumbnail?.path ?? "",
                                                        imageExtension: model.data?.results.first?.thumbnail?.imageExtension ?? "",
                                                        description: "description",
                                                        availableComicsCount: 2,
                                                        availableSeriesCount: 3,
                                                        availableStoriesCount: 4,
                                                        availableEventsCount: 5)
        return viewModel
    }
}
