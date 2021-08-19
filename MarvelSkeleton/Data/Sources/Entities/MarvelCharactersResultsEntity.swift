import Foundation

struct MarvelCharactersResultsEntity: Codable {
    let id: Int32?
    let name: String?
    let thumbnail: MarvelCharacterImageEntity?
    let description: String?
    let comics: MarvelCharactersAvailablityCountEntity?
    let series: MarvelCharactersAvailablityCountEntity?
    let stories: MarvelCharactersAvailablityCountEntity?
    let events: MarvelCharactersAvailablityCountEntity?

    func domainModel() throws -> MarvelCharactersResultsModel {
        guard let id = id else {
            let error = EncodingError.Context(codingPath: [MarvelCharactersResultsEntity.CodingKeys.id],
                                              debugDescription: "Invalid format for Id.")
            throw EncodingError.invalidValue("", error)
        }
        return MarvelCharactersResultsModel(id: id, name: name ?? "",
                                            thumbnail: try thumbnail?.domainModel(),
                                            description: description ?? "",
                                            comics: try comics?.domainModel(),
                                            series: try series?.domainModel(),
                                            stories: try stories?.domainModel(),
                                            events: try events?.domainModel())
    }
}
