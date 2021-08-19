import Foundation
import Moya

enum MarvelCharactersService {
    case getCharactersList(currentOffset: Int32)
    case getCharactersDetails(characterId: Int32)
}

extension MarvelCharactersService: BaseService {
    var mockName: String? {
        switch self {
        case .getCharactersList:
            return "marvelCharactersList"
        case .getCharactersDetails:
            return "marvelCharactersDetail"
        }
    }

    var servicePath: String {
        "/v1/public"
    }

    var path: String {
        switch self {
        case .getCharactersList:
            return "/characters"
        case let .getCharactersDetails(characterId):
            return "/characters/\(characterId)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getCharactersList, .getCharactersDetails:
            return .get
        }
    }

    var encoding: ParameterEncoding {
        return URLEncoding.default
    }

    var task: Task {
        let timeStamp = "\(Date().timeIntervalSince1970)"
        let hash = (timeStamp + Marvel.privateKey + Marvel.publicKey).md5
        switch self {
        case let .getCharactersList(offset):
            return .requestParameters(parameters: ["apikey": Marvel.publicKey, "ts": timeStamp, "hash": hash, "offset": "\(offset)"],
                                      encoding: encoding)
        case .getCharactersDetails:
            return .requestParameters(parameters: ["apikey": Marvel.publicKey, "ts": timeStamp, "hash": hash],
                                      encoding: encoding)
        }
    }
}
