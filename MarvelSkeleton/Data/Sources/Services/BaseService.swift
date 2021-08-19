import Alamofire
import Foundation
import Moya

protocol BaseService: TargetType {
    static var mockBundle: String { get }
    var mockName: String? { get }
    var servicePath: String { get }
    var contentType: String { get }
    var encoding: ParameterEncoding { get }
}

enum Marvel {
  static let publicKey = "6eb00144334187cc5da10defe010980c"
  static let privateKey = "41c0835705afefa678bc9f0ced15dc6fabed8520"
}

extension BaseService {
    static var mockBundle: String {
        "com.marvel.MarvelSkeleton"
    }

    var baseURL: URL {
        return URL(string: "https://gateway.marvel.com" + servicePath)!
    }

    var contentType: String {
        return "application/json; charset=utf-8"
    }

    var mockExtension: String {
        return "json"
    }

    var validationType: ValidationType {
        return .successAndRedirectCodes
    }
    
    var sampleData: Data {
        guard let mockBundle = Bundle(identifier: Self.mockBundle),
            let url = mockBundle.url(forResource: mockName, withExtension: mockExtension),
            let data = try? Data(contentsOf: url) else {
                return Data()
        }
        return data
    }

    var headers: [String: String]? {
        return ["Content-type": contentType]
    }
}
