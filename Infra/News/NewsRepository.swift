//
//  NewsRepository.swift
//  Infra
//
//  Created by Kyuma Morita on 2023/12/12.
//

import Domain

public struct NewsRepository: NewsRepositoryProtocol {

    public init() {}

    public func fetchStoryIDs(strategy: NewsListUseCase.Strategy) async throws -> [Story.ID] {
        try await APIClient().connect(config: NewsRequest.GetStoryIDs(strategy: strategy))
    }
}

private struct NewsRequest {
    struct GetStoryIDs: RequestConfiguration {
        typealias Response = [Story.ID]
        let method = Method.get
        let endpoint: Endpoint
        let headers: [String : String] = [:]
        let parameters: [String : Any] = [:]
        let needsIDToken = true

        init(strategy: NewsListUseCase.Strategy) {
            switch strategy {
            case .new:
                endpoint = Endpoint(
                    hostName: "https://hacker-news.firebaseio.com",
                    path: "/v0/newstories.json"
                )
            case .popular:
                endpoint = Endpoint(
                    hostName: "https://hacker-news.firebaseio.com",
                    path: "/v0/beststories.json"
                )
            }
        }
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
