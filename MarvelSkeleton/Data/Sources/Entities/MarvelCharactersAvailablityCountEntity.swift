import Foundation

struct MarvelCharactersAvailablityCountEntity: Codable {
    let available: Int?

    func domainModel() throws -> MarvelCharactersAvailablityCountModel {
        return MarvelCharactersAvailablityCountModel(available: available ?? 0)
    }
}
