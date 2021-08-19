@testable import MarvelSkeleton
import XCTest

class MarvelCharactersAvailablityCountModelTests: XCTestCase {
    func testMarvelCharacterAvailablityCountModelEqual() throws {
        let marvelCharacterAvailablityCountModel = getMarvelCharactersAvailablityCountModel()
        let anotherMarvelCharacterAvailablityCountModel = getMarvelCharactersAvailablityCountModel()
        XCTAssertEqual(marvelCharacterAvailablityCountModel, anotherMarvelCharacterAvailablityCountModel)
    }

    func testMarvelCharacterAvailablityCountModelNotEqual() throws {
        let marvelCharacterAvailablityCountModel = getMarvelCharactersAvailablityCountModel()
        let anotherMarvelCharacterAvailablityCountModel = MarvelCharactersAvailablityCountModel(available: 4)
        XCTAssertNotEqual(marvelCharacterAvailablityCountModel, anotherMarvelCharacterAvailablityCountModel)
    }
}

private extension MarvelCharactersAvailablityCountModelTests {
    func getMarvelCharactersAvailablityCountModel() -> MarvelCharactersAvailablityCountModel {
        return MarvelCharactersAvailablityCountModel(available: 3)
    }
}
