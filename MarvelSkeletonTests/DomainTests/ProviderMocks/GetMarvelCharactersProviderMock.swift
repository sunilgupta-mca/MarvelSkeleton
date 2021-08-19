@testable import MarvelSkeleton
import Foundation

final class GetMarvelCharactersProviderMock: MarvelCharactersProviderProtocol {
    var result: Result<MarvelCharactersModel, UseCaseError>?
    var characterDetailResult: Result<MarvelCharacterDetailModel, UseCaseError>?

    func getMarvelCharactersList(currentOffset: Int32, completion: @escaping GetMarvelCharactersListClosure) {
        guard let response = result else {
            return
        }
        completion(response)
    }

    func getMarvelCharactersDetail(characterId: Int32, completion: @escaping GetMarvelCharactersDetailClosure) {
        guard let response = characterDetailResult else {
            return
        }
        completion(response)
    }
}
