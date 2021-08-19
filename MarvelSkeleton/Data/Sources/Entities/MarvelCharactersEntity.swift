import Foundation

struct MarvelCharactersEntity: Codable {
    let data: MarvelCharactersDataEntity?

    func domainModel() throws -> MarvelCharactersModel {
        return MarvelCharactersModel(data: try data?.domainModel())
    }
}
