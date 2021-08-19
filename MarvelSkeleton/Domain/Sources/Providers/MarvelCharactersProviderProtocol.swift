protocol MarvelCharactersProviderProtocol: ProviderProtocol {
    func getMarvelCharactersList(currentOffset: Int32, completion: @escaping GetMarvelCharactersListClosure)
    func getMarvelCharactersDetail(characterId: Int32, completion: @escaping GetMarvelCharactersDetailClosure)
}
