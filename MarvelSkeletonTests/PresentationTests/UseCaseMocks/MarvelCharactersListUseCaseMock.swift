@testable import MarvelSkeleton

class MarvelCharactersListUseCaseMock: GetMarvelCharactersListUseCaseProtocol {
    var result: Result<MarvelCharactersModel, UseCaseError>?

    func execute(_ params: @escaping GetMarvelCharactersListClosure) {
        guard let result = result else {
            return
        }
        params(result)
    }
}

