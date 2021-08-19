@testable import MarvelSkeleton
import XCTest

class MarvelCharactersResultsModelTests: XCTestCase {
    func testMarvelCharactersResultsModelEqual() throws {
        let marvelCharactersResultsModel = getMarvelCharactersResultsModel()
        let anotherMarvelCharactersResultsModel = getMarvelCharactersResultsModel()
        XCTAssertEqual(marvelCharactersResultsModel, anotherMarvelCharactersResultsModel)
    }

    func testMarvelCharactersResultsModelNotEqual() throws {
        let marvelCharactersResultsModel = getMarvelCharactersResultsModel()
        let anotherMarvelCharactersResultsModel = MarvelCharactersResultsModel(id: 1011334,
                                                                             name: "3-D Man",
                                                                             thumbnail: getMarvelCharacterImageModel(), description: "description",
                                                                             comics: MarvelCharactersAvailablityCountModel(available: 2),
                                                                             series: MarvelCharactersAvailablityCountModel(available: 3),
                                                                             stories: MarvelCharactersAvailablityCountModel(available: 4),
                                                                             events: MarvelCharactersAvailablityCountModel(available: 5))
        XCTAssertNotEqual(marvelCharactersResultsModel, anotherMarvelCharactersResultsModel)
    }
}

private extension MarvelCharactersResultsModelTests {
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
