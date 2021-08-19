@testable import MarvelSkeleton
import XCTest

class MarvelCharactersDetailBuilderTests: XCTestCase {
    var view: MarvelCharactersDetailView = MarvelCharactersDetailBuilder().build(characterId: 1011334)
    var presenter: MarvelCharactersDetailPresenterProtocol = MarvelCharactersDetailPresenter(marvelCharactersDetailUseCase: GetMarvelCharactersDetailUseCase(withProvider: MarvelCharactersProvider()))

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
