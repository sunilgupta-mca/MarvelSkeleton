@testable import MarvelSkeleton
import XCTest

class MarvelCharactersModelTests: XCTestCase {
    func testMarvelCharactersModelEqual() throws {
        let marvelCharactersModel = getMarvelCharactersModel()
        let anotherMarvelCharactersModel = getMarvelCharactersModel()
        XCTAssertEqual(marvelCharactersModel, anotherMarvelCharactersModel)
    }

    func testMarvelCharactersModelNotEqual() throws {
        let marvelCharactersModel = getMarvelCharactersModel()
        let marvelCharactersDataModel = MarvelCharactersDataModel(offset: 0,
                                                                limit: 20,
                                                                total: 40,
                                                                count: 40,
                                                                results: [getMarvelCharactersResultsModel()])
        let anotherMarvelCharactersModel = MarvelCharactersModel(data: marvelCharactersDataModel)
        XCTAssertNotEqual(marvelCharactersModel, anotherMarvelCharactersModel)
    }
}

private extension MarvelCharactersModelTests {
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
}
