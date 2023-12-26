//
//  NewsRepository.swift
//  Infra
//
//  Created by Kyuma Morita on 2023/12/12.
//

import Domain
import Utility

// Use Hacker News API.
// Please see the following URL for details
// https://github.com/HackerNews/API

public struct NewsRepository: NewsRepositoryProtocol {
    public enum Error: Swift.Error {
        case decodingError
        case unknown
    }

    public init() {}

    public func fetchStoryIDs(strategy: NewsListUseCase.Strategy) async throws -> [Story.ID] {
        do {
            return try await APIClient().connect(config: NewsRequest.GetStoryIDs(strategy: strategy))
        } catch {
            throw NewsRepository.Error.unknown
        }
    }

    public func fetchStory(id: Story.ID) async throws -> Story {
        do {
            return try await APIClient().connect(config: NewsRequest.Get(id: id))
        } catch {
            throw NewsRepository.Error.unknown
        }
    }
}

private struct NewsRequest {
    private static let API_URL_STRING = "https://hacker-news.firebaseio.com"

    struct GetStoryIDs: RequestConfiguration {
        typealias Response = [Story.ID]
        let method = Method.get
        let endpoint: Endpoint
        let headers: [String : String] = [:]
        let parameters: [String : Any] = [:]
        let needsIDToken = true

        init(strategy: NewsListUseCase.Strategy) throws {
            switch strategy {
            case .new:
                endpoint = Endpoint(
                    hostName: API_URL_STRING,
                    path: "/v0/newstories.json"
                )
            case .popular:
                endpoint = Endpoint(
                    hostName: API_URL_STRING,
                    path: "/v0/beststories.json"
                )
            }
        }
        func response(from data: Data) throws -> Response {
            let dtos = try JSONDecoder().decode([StoryIDDTO].self, from: data)
            return dtos.map { Story.ID(dto: $0) }
        }
    }

    struct Get: RequestConfiguration {
        typealias Response = Story
        let method = Method.get
        let endpoint: Endpoint
        let headers: [String : String] = [:]
        let parameters: [String : Any] = [:]
        let needsIDToken = true

        init(id: Story.ID) {
            endpoint = Endpoint(
                hostName: "https://hacker-news.firebaseio.com",
                path: "/v0/item/\(id.value).json"
            )
        }
        func response(from data: Data) throws -> Response {
            let dto = try JSONDecoder().decode(StoryDTO.self, from: data)
            return try Story(dto: dto)
        }
    }
}

private struct StoryIDDTO: Decodable {
    let value: Int

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let intValue = try container.decode(Int.self)
        self.value = intValue
    }
}

private struct StoryDTO: Decodable {
    let id: Int
    let authorName: String
    let title: String
    let urlString: String
    let score: Int
    let time: TimeInterval

    enum CodingKeys: String, CodingKey {
        case id
        case authorName = "by"
        case title
        case urlString = "url"
        case score
        case time
    }
}

private extension Story.ID {
    init(dto: StoryIDDTO) {
        self = Story.ID(value: dto.value)
    }
}

private extension Story {
    init(dto: StoryDTO) throws {
        guard let url = URL(string: dto.urlString) else {
            throw NewsRepository.Error.decodingError
        }

        self = Story(
            id: Story.ID(value: dto.id),
            authorName: dto.authorName,
            title: dto.title,
            url: url,
            score: dto.score,
            createdAt: Date(timeIntervalSince1970: dto.time)
        )
    }
}
