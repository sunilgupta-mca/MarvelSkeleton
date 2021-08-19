struct MarvelCharactersResultsModel: Equatable {
    let id: Int32
    let name: String
    let thumbnail: MarvelCharacterImageModel?
    let description: String?
    let comics: MarvelCharactersAvailablityCountModel?
    let series: MarvelCharactersAvailablityCountModel?
    let stories: MarvelCharactersAvailablityCountModel?
    let events: MarvelCharactersAvailablityCountModel?

    init(id: Int32,
         name: String,
         thumbnail: MarvelCharacterImageModel?,
         description: String?,
         comics: MarvelCharactersAvailablityCountModel?,
         series: MarvelCharactersAvailablityCountModel?,
         stories: MarvelCharactersAvailablityCountModel?,
         events: MarvelCharactersAvailablityCountModel?) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.description = description
        self.comics = comics
        self.series = series
        self.stories = stories
        self.events = events
    }
}
