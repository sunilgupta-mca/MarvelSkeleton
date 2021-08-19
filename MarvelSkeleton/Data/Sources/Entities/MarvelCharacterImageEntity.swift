import Foundation

struct MarvelCharacterImageEntity: Codable {
    let path: String?
    let imageExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
    
    func domainModel() throws -> MarvelCharacterImageModel {
        return MarvelCharacterImageModel(path: path ?? "", imageExtension: imageExtension ?? "")
    }
}
