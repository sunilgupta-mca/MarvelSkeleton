@testable import MarvelSkeleton
import XCTest

class MarvelCharactersAvailablityCountEntityTests: XCTestCase {
    func testDomainModel() {
        let marvelCharactersAvailablityCountEntity = MarvelCharactersAvailablityCountEntity(available: 2)
        XCTAssertNoThrow(try marvelCharactersAvailablityCountEntity.domainModel())
    }
}
