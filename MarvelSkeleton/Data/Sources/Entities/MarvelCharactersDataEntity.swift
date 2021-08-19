import Foundation

struct MarvelCharactersDataEntity: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [MarvelCharactersResultsEntity]?

    func domainModel() throws -> MarvelCharactersDataModel {
        return MarvelCharactersDataModel(offset: offset ?? 0, limit: limit ?? 0,
                                        total: total ?? 0, count: count ?? 0,
                                        results: results?.compactMap { try? $0.domainModel() } ?? [])
    }
}
