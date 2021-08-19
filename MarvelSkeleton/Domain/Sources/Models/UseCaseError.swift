enum UseCaseError: Error {
    case network(InternetError)
    case parse(Swift.Error)
}

enum InternetError {
    case noInternetConnection(Swift.Error)
    case general(Swift.Error)
}
