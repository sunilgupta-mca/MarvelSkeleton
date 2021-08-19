typealias GetMarvelCharactersDetailClosure = (_ result: Result<MarvelCharacterDetailModel, UseCaseError>) -> Void

struct MarvelCharactersDetailParams {
    let characterId: Int32
    let completion: GetMarvelCharactersDetailClosure

    init(characterId: Int32, completion: @escaping GetMarvelCharactersDetailClosure) {
        self.characterId = characterId
        self.completion = completion
    }
}

protocol GetMarvelCharactersDetailUseCaseProtocol: AnyObject {
    func execute(_ params: MarvelCharactersDetailParams)
}

class GetMarvelCharactersDetailUseCase: GetMarvelCharactersDetailUseCaseProtocol {
    private var provider: MarvelCharactersProviderProtocol

    init(withProvider provider: MarvelCharactersProviderProtocol) {
        self.provider = provider
    }
}

extension GetMarvelCharactersDetailUseCase {
    func execute(_ params: MarvelCharactersDetailParams) {
        provider.getMarvelCharactersDetail(characterId: params.characterId, completion: params.completion)
    }
}
