@testable import MarvelSkeleton
import XCTest

class MarvelCharactersViewModelTests: XCTestCase {
    func testMarvelCharactersResultsModelEqual() throws {
        let marvelCharactersViewModel = getMarvelCharactersViewModel()
        let anotherMarvelCharactersViewModel = getMarvelCharactersViewModel()
        XCTAssertEqual(marvelCharactersViewModel, anotherMarvelCharactersViewModel)
    }

    func testMarvelCharactersResultsModelNotEqual() throws {
        let marvelCharactersViewModel = getMarvelCharactersViewModel()
        let anotherMarvelCharactersViewModel = MarvelCharactersViewModel(id: 1011334, name: "3-D Man")
        XCTAssertNotEqual(marvelCharactersViewModel, anotherMarvelCharactersViewModel)
    }
}

private extension MarvelCharactersViewModelTests {
    func getMarvelCharactersViewModel() -> MarvelCharactersViewModel {
        return MarvelCharactersViewModel(id: 1017265, name: "Thor")
    }
}
