@testable import MarvelSkeleton
import XCTest

class MarvelCharactersDataModelTests: XCTestCase {
    func testMarvelCharactersDataModelEqual() throws {
        let marvelCharactersDataModel = getMarvelCharactersDataModel()
        let anotherMarvelCharactersDataModel = getMarvelCharactersDataModel()
        XCTAssertEqual(marvelCharactersDataModel, anotherMarvelCharactersDataModel)
    }

    func testMarvelCharactersDataModelNotEqual() throws {
        let marvelCharactersDataModel = getMarvelCharactersDataModel()
        let anotherMarvelCharactersDataModel = MarvelCharactersDataModel(offset: 0,
                                                                       limit: 20,
                                                                       total: 40,
                                                                       count: 40,
                                                                       results: [getMarvelCharactersResultsModel()])
        XCTAssertNotEqual(marvelCharactersDataModel, anotherMarvelCharactersDataModel)
    }
}

private extension MarvelCharactersDataModelTests {
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
