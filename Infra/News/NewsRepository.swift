//
//  NewsRepository.swift
//  Infra
//
//  Created by Kyuma Morita on 2023/12/12.
//

import Domain

public struct NewsRepository: NewsRepositoryProtocol {

    public init() {}

    public func fetchStoryIDs() async throws -> [Story.ID] {
        try await APIClient().connect(config: NewsRequest.GetStoryIDs())
    }
}

private struct NewsRequest {
    struct GetStoryIDs: RequestConfiguration {
        typealias Response = [Story.ID]
        let method = Method.get
        let endpoint = Endpoint(
            hostName: "https://hacker-news.firebaseio.com",
            path: "/v0/newstories.json"
        )
        let headers: [String : String] = [:]
        let parameters: [String : Any] = [:]
        let needsIDToken = true

        func response(from data: Data) throws -> Response {
            let dtos = try JSONDecoder().decode([StoryIDDTO].self, from: data)
            return dtos.map { Story.ID(dto: $0) }
        }
    }
}

struct StoryIDDTO: Decodable {
    let value: String

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let intValue = try container.decode(Int.self)
        self.value = String(intValue)
    }
}

extension Story.ID {
    init(dto: StoryIDDTO) {
        self = Story.ID(value: dto.value)
    }
}
