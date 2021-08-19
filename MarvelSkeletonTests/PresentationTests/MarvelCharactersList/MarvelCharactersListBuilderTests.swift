@testable import MarvelSkeleton
import XCTest

class MarvelCharactersListBuilderTests: XCTestCase {
    var view: MarvelCharactersListView = MarvelCharactersListBuilder().build()
    var presenter: MarvelCharactersListPresenterProtocol = MarvelCharactersListPresenter(marvelCharactersListUseCase: GetMarvelCharactersListUseCase(withProvider: MarvelCharactersProvider()))

    override func setUp() {
        super.setUp()
        presenter.view = view
        view.presenter = presenter
    }

    func testBuild() {
        let dummyView = view
        XCTAssertNotNil(dummyView)
        XCTAssertNotNil(dummyView.presenter)
        XCTAssertNotNil(presenter.view)
        XCTAssert(dummyView === presenter.view)
        XCTAssert(dummyView.presenter === presenter)
    }
}
