//
//  NewsListUseCase.swift
//  Domain
//
//  Created by Kyuma Morita on 2023/12/12.
//

/// TODO: Write struct document, and the reason why UseCase is used
public struct NewsListUseCase {
    public struct Dependency {
        public let newsRepository: NewsRepositoryProtocol
        public init(newsRepository: NewsRepositoryProtocol) {
            self.newsRepository = newsRepository
        }
    }

    private let dependency: Dependency

    public init(dependency: Dependency) {
        self.dependency = dependency
    }

    public func fetch() async throws -> [Story.ID] {
        try await dependency.newsRepository.fetchStoryIDs()
    }
}

/// Interface of functions to access api resources
public protocol NewsRepositoryProtocol {
    func fetchStoryIDs() async throws -> [Story.ID]
}
