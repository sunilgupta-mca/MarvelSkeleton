@testable import MarvelSkeleton

class MarvelCharactersListUseCaseMock: GetMarvelCharactersListUseCaseProtocol {
    var result: Result<MarvelCharactersModel, UseCaseError>?

    func execute(_ params: MarvelCharactersListParams) {
        guard let result = result else {
            return
        }
        params.completion(result)
    }
}

