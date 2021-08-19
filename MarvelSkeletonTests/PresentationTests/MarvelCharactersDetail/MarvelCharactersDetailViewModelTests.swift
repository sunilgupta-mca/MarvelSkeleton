@testable import MarvelSkeleton
import XCTest

class MarvelCharactersDetailViewModelTests: XCTestCase {
    func testMarvelCharactersResultsModelEqual() throws {
        let marvelCharactersDetailViewModel = getMarvelCharactersDetailViewModel()
        let anotherMarvelCharactersDetailViewModel = getMarvelCharactersDetailViewModel()
        XCTAssertEqual(marvelCharactersDetailViewModel, anotherMarvelCharactersDetailViewModel)
    }

    func testMarvelCharactersResultsModelNotEqual() throws {
        let imageUrl = "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784"
        let marvelCharactersDetailViewModel = getMarvelCharactersDetailViewModel()
        let anotherMarvelCharactersDetailViewModel = MarvelCharactersDetailViewModel(name: "Thor",
                                                                                  copyrightLabel: "© 2021 MARVEL",
                                                                                  imageUrl: imageUrl,
                                                                                  imageExtension: "jpg",
                                                                                  description: "Not Available",
                                                                                  availableComicsCount: 3,
                                                                                  availableSeriesCount: 4,
                                                                                  availableStoriesCount: 5,
                                                                                  availableEventsCount: 6)
        XCTAssertNotEqual(marvelCharactersDetailViewModel, anotherMarvelCharactersDetailViewModel)
    }
}

private extension MarvelCharactersDetailViewModelTests {
    func getMarvelCharactersDetailViewModel() -> MarvelCharactersDetailViewModel {
        let imageUrl = "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784"
        return MarvelCharactersDetailViewModel(name: "Thor",
                                               copyrightLabel: "© 2021 MARVEL",
                                               imageUrl: imageUrl,
                                               imageExtension: "jpg",
                                               description: "Not Available",
                                               availableComicsCount: 2,
                                               availableSeriesCount: 3,
                                               availableStoriesCount: 4,
                                               availableEventsCount: 5)
    }
}
