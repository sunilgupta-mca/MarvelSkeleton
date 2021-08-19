struct MarvelCharacterDetailModel: Equatable {
    let copyright: String
    let data: MarvelCharactersDataModel?
    
    init(copyright: String,
         data: MarvelCharactersDataModel?) {
        self.copyright = copyright
        self.data = data
    }
}

