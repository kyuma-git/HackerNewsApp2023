//
//  RequestConfiguration.swift
//  Infra
//
//  Created by Kyuma Morita on 2023/12/10.
//

public enum Method {
    case get
    case post
    case put
    case patch
    case delete

    var stringValue: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .put: return "PUT"
        case .patch: return "PATCH"
        case .delete: return "DELETE"
        }
    }
}

public struct Endpoint {
    public init(hostName: String, path: String) {
        self.hostName = hostName
        self.path = path
    }
    
    public let hostName: String
    public let path: String

    var url: URL {
        var urlComponents = URLComponents(string: hostName)!
        urlComponents.path = path

        return urlComponents.url!
    }
}

public protocol RequestConfiguration {
    associatedtype Response

    var method: Method { get }
    var endpoint: Endpoint { get }
    var headers: [String: String] { get }
    var parameters: [String: Any] { get }
    var needsIDToken: Bool { get }

    func response(from data: Data) async throws -> Response
}

public protocol DecodableRequestConfiguration: RequestConfiguration where Response: Decodable { }
public extension DecodableRequestConfiguration {
    func response(from data: Data) throws -> Response {
        return try JSONDecoder().decode(Response.self, from: data)
    }
}

