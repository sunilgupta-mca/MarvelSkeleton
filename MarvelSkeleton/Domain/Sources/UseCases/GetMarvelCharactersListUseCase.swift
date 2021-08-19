typealias GetMarvelCharactersListClosure = (_ result: Result<MarvelCharactersModel, UseCaseError>) -> Void

struct MarvelCharactersListParams {
    let currentOffset: Int32
    let completion: GetMarvelCharactersListClosure

    init(currentOffset: Int32, completion: @escaping GetMarvelCharactersListClosure) {
        self.currentOffset = currentOffset
        self.completion = completion
    }
}

protocol GetMarvelCharactersListUseCaseProtocol: AnyObject {
    func execute(_ params: MarvelCharactersListParams)
}

class GetMarvelCharactersListUseCase: GetMarvelCharactersListUseCaseProtocol {
    private var provider: MarvelCharactersProviderProtocol

    init(withProvider provider: MarvelCharactersProviderProtocol) {
        self.provider = provider
    }
}

extension GetMarvelCharactersListUseCase {
    func execute(_ params: MarvelCharactersListParams) {
        provider.getMarvelCharactersList(currentOffset: params.currentOffset,
                                         completion: params.completion)
    }
}
