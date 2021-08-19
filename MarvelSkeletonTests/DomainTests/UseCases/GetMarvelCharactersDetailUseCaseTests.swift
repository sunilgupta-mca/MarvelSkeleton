@testable import MarvelSkeleton
import XCTest

class GetMarvelCharactersDetailUseCaseTests: XCTestCase {
    var marvelCharactersDetailUseCase: GetMarvelCharactersDetailUseCaseProtocol!
    var mockMarvelCharactersDetailProvider = GetMarvelCharactersProviderMock()

    override func setUp() {
        super.setUp()
        marvelCharactersDetailUseCase = GetMarvelCharactersDetailUseCase(withProvider: mockMarvelCharactersDetailProvider)
    }

    func testGetMarvelCharactersDetailSuccess() {
        let success = expectation(description: "success")
        mockMarvelCharactersDetailProvider.characterDetailResult = .success(getMarvelCharacterDetailModel())

        let params = MarvelCharactersDetailParams(characterId: 1011334) { result in
            if case let .success(response) = result {
                XCTAssertNotNil(response)
                success.fulfill()
            }
        }
        marvelCharactersDetailUseCase.execute(params)
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetMarvelCharactersDetailFailure() {
        let serverError = expectation(description: "serverError")
        let error = NSError(domain: NSURLErrorDomain, code: 0, userInfo: nil)
        mockMarvelCharactersDetailProvider.characterDetailResult = .failure(.network(.general(error)))
        let params = MarvelCharactersDetailParams(characterId: 1011334) { result in
            if case .failure = result {
                serverError.fulfill()
            }
        }
        marvelCharactersDetailUseCase.execute(params)
        waitForExpectations(timeout: 1, handler: nil)
    }
}

private extension GetMarvelCharactersDetailUseCaseTests {
    func getMarvelCharacterDetailModel() -> MarvelCharacterDetailModel {
        return MarvelCharacterDetailModel(copyright: "© 2021 MARVEL",
                                         data: getMarvelCharactersDataModel())
    }

    func getMarvelCharactersDataModel() -> MarvelCharactersDataModel {
        return MarvelCharactersDataModel(offset: 0,
                                         limit: 10,
                                         total: 50,
                                         count: 50,
                                         results: [getMarvelCharactersResultsModel()])
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
}
