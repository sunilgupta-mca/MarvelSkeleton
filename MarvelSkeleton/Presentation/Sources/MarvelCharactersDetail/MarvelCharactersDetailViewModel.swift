struct MarvelCharactersDetailViewModel: Equatable {
    let name: String
    let copyrightLabel: String
    let imageUrl: String
    let imageExtension: String
    let description: String?
    let availableComicsCount: Int
    let availableSeriesCount: Int
    let availableStoriesCount: Int
    let availableEventsCount: Int

    init(name: String,
         copyrightLabel: String,
         imageUrl: String,
         imageExtension: String,
         description: String?,
         availableComicsCount: Int,
         availableSeriesCount: Int,
         availableStoriesCount: Int,
         availableEventsCount: Int) {
        self.name = name
        self.copyrightLabel = copyrightLabel
        self.imageUrl = imageUrl
        self.imageExtension = imageExtension
        self.description = description
        self.availableComicsCount = availableComicsCount
        self.availableSeriesCount = availableSeriesCount
        self.availableStoriesCount = availableStoriesCount
        self.availableEventsCount = availableEventsCount
    }
}

extension MarvelCharacterDetailModel {
    func mapDomainToViewModel() -> MarvelCharactersDetailViewModel {
        guard let result = self.data?.results.first else {
            return MarvelCharactersDetailViewModel(name: "",
                                                   copyrightLabel: copyright,
                                                   imageUrl: "",
                                                   imageExtension: "",
                                                   description: "",
                                                   availableComicsCount: 0,
                                                   availableSeriesCount: 0,
                                                   availableStoriesCount: 0,
                                                   availableEventsCount: 0)
        }
        let viewModel = MarvelCharactersDetailViewModel(name: result.name ,
                                                        copyrightLabel: copyright,
                                                        imageUrl: result.thumbnail?.path ?? "",
                                                        imageExtension: result.thumbnail?.imageExtension ?? "",
                                                        description: result.description ?? "",
                                                        availableComicsCount: result.comics?.available ?? 0,
                                                        availableSeriesCount: result.series?.available ?? 0,
                                                        availableStoriesCount: result.stories?.available ?? 0,
                                                        availableEventsCount: result.events?.available ?? 0)
        return viewModel
    }
}
