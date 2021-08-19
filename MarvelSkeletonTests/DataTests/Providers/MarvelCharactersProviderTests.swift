@testable import MarvelSkeleton
import Moya
import XCTest

class MarvelCharactersProviderTests: XCTestCase {
    private let timedOutResponse = EndpointSampleResponse.networkError(NSError(domain: NSURLErrorDomain, code: URLError.timedOut.rawValue, userInfo: nil))
    private let errorResponse = EndpointSampleResponse.networkResponse(500, Data())
    private let emptyResponse = EndpointSampleResponse.networkResponse(200, Data())
    private let emptyResponse204 = EndpointSampleResponse.networkResponse(204, Data())

    private func marvelCharactersProvider(_ response: EndpointSampleResponse? = nil,
                                          stub: @escaping MoyaProvider<MarvelCharactersService>
        .StubClosure = MoyaProvider.immediatelyStub) -> MarvelCharactersProviderProtocol {
        var marvelCharactersListClosure = MoyaProvider<MarvelCharactersService>.defaultEndpointMapping
        if let response = response {
            marvelCharactersListClosure = { (target: MarvelCharactersService) -> Endpoint in
                return Endpoint(url: URL(target: target).absoluteString,
                                sampleResponseClosure: { response },
                                method: target.method,
                                task: target.task,
                                httpHeaderFields: target.headers)
            }
        }
        let marvelCharactersService = MoyaProvider<MarvelCharactersService>(
            endpointClosure: marvelCharactersListClosure,
            stubClosure: stub)
        return MarvelCharactersProvider(marvelCharactersService: marvelCharactersService)
    }

    func testMarvelCharactersProviderInit() {
        let provider = MarvelCharactersProvider()
        XCTAssertNotNil(provider)
    }

    func testGetMarvelCharactersListSuccess() {
        let success = expectation(description: "success")
        marvelCharactersProvider().getMarvelCharactersList(currentOffset: 0) { (result) in
            if case let .success(marvelCharactersListResponse) = result {
                XCTAssertNotNil(marvelCharactersListResponse)
                success.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetMarvelCharactersListEmptyResponse() {
        let empty = expectation(description: "empty")
        marvelCharactersProvider(emptyResponse204).getMarvelCharactersList(currentOffset: 0) { result in
                if case .success = result {
                    empty.fulfill()
                }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetMarvelCharactersListTimeoutFailure() {
        let timeoutResponse = expectation(description: "timeoutResponse")
        marvelCharactersProvider(timedOutResponse).getMarvelCharactersList(currentOffset: 0) { result in
            if case let .failure(useCaseError) = result,
               case let .network(.noInternetConnection(underlyingError)) = useCaseError,
               case let MoyaError.underlying(error, _) = underlyingError {
                let netError = error as NSError
                XCTAssertEqual(netError.domain, NSURLErrorDomain)
                XCTAssertEqual(netError.code, URLError.timedOut.rawValue)
                timeoutResponse.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetMarvelCharactersListServerFailure() {
        let serverFailure = expectation(description: "serverFailure")
        marvelCharactersProvider(errorResponse).getMarvelCharactersList(currentOffset: 0) { result in
            if case let .failure(useCaseError) = result,
               case let .network(.noInternetConnection(underlyingError)) = useCaseError,
               case let MoyaError.underlying(_, response) = underlyingError {
                XCTAssertEqual(response?.statusCode, 500)
                serverFailure.fulfill()
           }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetMarvelCharactersListParseError() {
        let parseError = expectation(description: "parseError")
        marvelCharactersProvider(emptyResponse).getMarvelCharactersList(currentOffset: 0) { result in
            if case .failure = result {
                parseError.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetMarvelCharactersDetailSuccess() {
        let success = expectation(description: "success")
        marvelCharactersProvider().getMarvelCharactersDetail(characterId: 1011334) { (result) in
            if case let .success(marvelCharactersDetailResponse) = result {
                XCTAssertNotNil(marvelCharactersDetailResponse)
                success.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetMarvelCharactersDetailTimeoutFailure() {
        let timeoutResponse = expectation(description: "timeoutResponse")
        marvelCharactersProvider(timedOutResponse).getMarvelCharactersDetail(characterId: 1011334) { result in
            if case let .failure(useCaseError) = result,
               case let .network(.noInternetConnection(underlyingError)) = useCaseError,
               case let MoyaError.underlying(error, _) = underlyingError {
                let netError = error as NSError
                XCTAssertEqual(netError.domain, NSURLErrorDomain)
                XCTAssertEqual(netError.code, URLError.timedOut.rawValue)
                timeoutResponse.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetMarvelCharactersDetailServerFailure() {
        let serverFailure = expectation(description: "serverFailure")
        marvelCharactersProvider(errorResponse).getMarvelCharactersDetail(characterId: 1011334) { result in
            if case let .failure(useCaseError) = result,
               case let .network(.noInternetConnection(underlyingError)) = useCaseError,
               case let MoyaError.underlying(_, response) = underlyingError {
                XCTAssertEqual(response?.statusCode, 500)
                serverFailure.fulfill()
           }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetMarvelCharactersDetailParseError() {
        let parseError = expectation(description: "parseError")
        marvelCharactersProvider(emptyResponse).getMarvelCharactersDetail(characterId: 1011334) { result in
            if case .failure = result {
                parseError.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
