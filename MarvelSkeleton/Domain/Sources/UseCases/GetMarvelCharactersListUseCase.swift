typealias GetMarvelCharactersListClosure = (_ result: Result<MarvelCharactersModel, UseCaseError>) -> Void

protocol GetMarvelCharactersListUseCaseProtocol: AnyObject {
    func execute(_ params: @escaping GetMarvelCharactersListClosure)
}

class GetMarvelCharactersListUseCase: GetMarvelCharactersListUseCaseProtocol {
    private var provider: MarvelCharactersProviderProtocol

    init(withProvider provider: MarvelCharactersProviderProtocol) {
        self.provider = provider
    }
}

extension GetMarvelCharactersListUseCase {
    func execute(_ params: @escaping GetMarvelCharactersListClosure) {
        provider.getMarvelCharactersList(completion: params)
    }
}
