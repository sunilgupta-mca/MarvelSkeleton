@testable import MarvelSkeleton
import XCTest

class MarvelCharacterDetailModelTests: XCTestCase {
    func testMarvelCharacterDetailModelEqual() throws {
        let marvelCharacterDetailModel = getMarvelCharacterDetailModel()
        let anotherMarvelCharacterDetailModel = getMarvelCharacterDetailModel()
        XCTAssertEqual(marvelCharacterDetailModel, anotherMarvelCharacterDetailModel)
    }

    func testMarvelCharacterDetailModelNotEqual() throws {
        let marvelCharacterDetailModel = getMarvelCharacterDetailModel()
        let anotherMarvelCharacterDetailModel = MarvelCharacterDetailModel(copyright: "© 2020 MARVEL",
                                                                         data: getMarvelCharactersDataModel())
        XCTAssertNotEqual(marvelCharacterDetailModel, anotherMarvelCharacterDetailModel)
    }
}

private extension MarvelCharacterDetailModelTests {
    func getMarvelCharacterDetailModel() -> MarvelCharacterDetailModel {
        return MarvelCharacterDetailModel(copyright: "© 2021 MARVEL",
                                         data: getMarvelCharactersDataModel())
    }

    func getMarvelCharacterImageModel() -> MarvelCharacterImageModel {
        let imagePath = "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784"
        return MarvelCharacterImageModel(path: imagePath, imageExtension: "jpg")
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
}
