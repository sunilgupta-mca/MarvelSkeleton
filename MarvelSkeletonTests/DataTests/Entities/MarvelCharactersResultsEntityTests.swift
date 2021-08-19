@testable import MarvelSkeleton
import XCTest

class MarvelCharactersResultsEntityTests: XCTestCase {
    func testDomainModel() {
        let imagePath = "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784"
        let marvelCharactersImageEntity = MarvelCharacterImageEntity(path: imagePath,
                                                                     imageExtension: "jpg")
        let marvelCharactersAvailablityCountEntity = MarvelCharactersAvailablityCountEntity(available: 2)
        let marvelCharactersResultsEntity = MarvelCharactersResultsEntity(id: 1011334,
                                                                          name: "3-D Man", thumbnail: marvelCharactersImageEntity,
                                                                          description: "",
                                                                          comics: marvelCharactersAvailablityCountEntity,
                                                                          series: marvelCharactersAvailablityCountEntity,
                                                                          stories: marvelCharactersAvailablityCountEntity,
                                                                          events: marvelCharactersAvailablityCountEntity)

        XCTAssertNoThrow(try marvelCharactersResultsEntity.domainModel())
    }
}
