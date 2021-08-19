@testable import MarvelSkeleton
import XCTest

class MarvelCharacterImageModelTests: XCTestCase {
    func testMarvelCharacterImageModelEqual() throws {
        let marvelCharacterImageModel = getMarvelCharacterImageModel()
        let anotherMarvelCharacterImageModel = getMarvelCharacterImageModel()
        XCTAssertEqual(marvelCharacterImageModel, anotherMarvelCharacterImageModel)
    }

    func testMarvelCharacterImageModelNotEqual() throws {
        let marvelCharacterImageModel = getMarvelCharacterImageModel()
        let anotherMarvelCharacterImageModel = MarvelCharacterImageModel(path: "http://i.thumbnail",
                                                                       imageExtension: "jpg")
        XCTAssertNotEqual(marvelCharacterImageModel, anotherMarvelCharacterImageModel)
    }
}

private extension MarvelCharacterImageModelTests {
    func getMarvelCharacterImageModel() -> MarvelCharacterImageModel {
        let imagePath = "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784"
        return MarvelCharacterImageModel(path: imagePath, imageExtension: "jpg")
    }
}
