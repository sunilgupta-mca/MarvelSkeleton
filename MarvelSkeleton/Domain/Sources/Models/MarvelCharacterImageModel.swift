struct MarvelCharacterImageModel: Equatable {
    let path: String
    let imageExtension: String

    init(path: String,
         imageExtension: String) {
        self.path = path
        self.imageExtension = imageExtension
    }
}
