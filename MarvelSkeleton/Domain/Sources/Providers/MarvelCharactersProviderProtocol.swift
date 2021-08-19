protocol MarvelCharactersProviderProtocol: ProviderProtocol {
    func getMarvelCharactersList(completion: @escaping GetMarvelCharactersListClosure)
    func getMarvelCharactersDetail(characterId: Int32, completion: @escaping GetMarvelCharactersDetailClosure)
}
