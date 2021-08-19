@testable import MarvelSkeleton
import XCTest

class MarvelCharacterImageEntityTests: XCTestCase {
    func testDomainModel() {
        let imagePath = "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784"
        let marvelCharactersImageEntity = MarvelCharacterImageEntity(path: imagePath,
            imageExtension: "jpg")
        XCTAssertNoThrow(try marvelCharactersImageEntity.domainModel())
    }
}
