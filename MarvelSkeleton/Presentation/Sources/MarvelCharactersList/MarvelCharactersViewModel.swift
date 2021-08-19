struct MarvelCharactersViewModel: Equatable {
    let id: Int32
    let name: String

    init(id: Int32, name: String) {
        self.id = id
        self.name = name
    }
}

extension MarvelCharactersResultsModel {
    func mapDomainToViewModel() -> MarvelCharactersViewModel {
        let viewModel = MarvelCharactersViewModel(id: id, name: name)
        return viewModel
    }
}
