struct MarvelCharactersDataModel: Equatable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [MarvelCharactersResultsModel]

    init(offset: Int,
         limit: Int,
         total: Int,
         count: Int,
         results: [MarvelCharactersResultsModel]) {
        self.offset = offset
        self.limit = limit
        self.total = count
        self.count = limit
        self.results = results
    }
}
