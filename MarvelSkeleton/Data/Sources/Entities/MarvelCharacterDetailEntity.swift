import Foundation

struct MarvelCharacterDetailEntity: Codable {
    let copyright: String?
    let data: MarvelCharactersDataEntity?

    func domainModel() throws -> MarvelCharacterDetailModel {
        return MarvelCharacterDetailModel(copyright: copyright ?? "",
                                         data: try data?.domainModel())
    }
}
