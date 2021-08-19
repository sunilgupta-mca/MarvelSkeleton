import Foundation

class DependencyManager {
  static func getMarvelCharactersListUseCase() -> GetMarvelCharactersListUseCase {
    return GetMarvelCharactersListUseCase(withProvider: MarvelCharactersProvider())
  }

    static func getMarvelCharactersDetailUseCase() -> GetMarvelCharactersDetailUseCase {
      return GetMarvelCharactersDetailUseCase(withProvider: MarvelCharactersProvider())
    }
}
