import Foundation
import Moya

final class MarvelCharactersProvider: MarvelCharactersProviderProtocol {
    private struct GetMarvelCharactersListCodeStatus {
        static let codeStatus204 = 204
    }

    let marvelCharactersService: MoyaProvider<MarvelCharactersService>

    convenience init() {
        self.init(marvelCharactersService: MoyaProvider<MarvelCharactersService>())
    }

    init(marvelCharactersService: MoyaProvider<MarvelCharactersService>) {
        self.marvelCharactersService = marvelCharactersService
    }

    func getMarvelCharactersList(completion: @escaping GetMarvelCharactersListClosure) {

        marvelCharactersService.request(.getCharactersList) { result in
            switch result {
            case .success(let response):
                do {
                    if response.statusCode == GetMarvelCharactersListCodeStatus.codeStatus204 {
                        completion(.success(MarvelCharactersModel(data: MarvelCharactersDataModel(offset: 0, limit: 0, total: 0, count: 0, results: []))))
                        return
                    }
                    let marvelCharactersEntity = try response.map(MarvelCharactersEntity.self)
                    completion(.success(try marvelCharactersEntity.domainModel()))
                } catch {
                    completion(.failure(.parse(error)))
                }
            case .failure(let error):
                completion(.failure(.network(.noInternetConnection(error))))
            }
        }
    }

    func getMarvelCharactersDetail(characterId: Int32, completion: @escaping GetMarvelCharactersDetailClosure) {
        marvelCharactersService.request(.getCharactersDetails(characterId: characterId)) { result in
            switch result {
            case .success(let response):
                do {
                    let charactersDetailEntity = try response.map(MarvelCharacterDetailEntity.self)
                    completion(.success(try charactersDetailEntity.domainModel()))
                } catch {
                    completion(.failure(.parse(error)))
                }
            case .failure(let error):
                completion(.failure(.network(.noInternetConnection(error))))
            }
        }
    }
}
