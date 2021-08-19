@testable import MarvelSkeleton

class MarvelCharactersDetailUseCaseMock: GetMarvelCharactersDetailUseCaseProtocol {
    var result: Result<MarvelCharacterDetailModel, UseCaseError>?

    func execute(_ params: MarvelCharactersDetailParams) {
        guard let result = result else {
            return
        }
        params.completion(result)
    }
}

