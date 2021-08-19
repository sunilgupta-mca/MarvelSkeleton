@testable import MarvelSkeleton
import XCTest

class GetMarvelCharactersListUseCaseTests: XCTestCase {
    var marvelCharactersListUseCase: GetMarvelCharactersListUseCaseProtocol!
    var mockMarvelCharactersListProvider = GetMarvelCharactersProviderMock()

    override func setUp() {
        super.setUp()
        marvelCharactersListUseCase = GetMarvelCharactersListUseCase(withProvider: mockMarvelCharactersListProvider)
    }

    func testGetMarvelCharactersListSuccess() {
        let success = expectation(description: "success")
        mockMarvelCharactersListProvider.result = .success(getMarvelCharactersModel())

        marvelCharactersListUseCase.execute { result in
            if case let .success(response) = result {
                XCTAssertNotNil(response)
                success.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetMarvelCharactersListFailure() {
        let serverError = expectation(description: "serverError")
        let error = NSError(domain: NSURLErrorDomain, code: 0, userInfo: nil)
        mockMarvelCharactersListProvider.result = .failure(.network(.general(error)))
        marvelCharactersListUseCase.execute { result in
            if case .failure = result {
                serverError.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}

private extension GetMarvelCharactersListUseCaseTests {
    func getMarvelCharactersModel() -> MarvelCharactersModel {
        MarvelCharactersModel(data: getMarvelCharactersDataModel())
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
}
