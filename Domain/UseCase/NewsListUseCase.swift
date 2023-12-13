//
//  NewsListUseCase.swift
//  Domain
//
//  Created by Kyuma Morita on 2023/12/12.
//

/// TODO: Write struct document, and the reason why UseCase is used
public struct NewsListUseCase {

    public struct Dependency {
        public let strategy: Strategy
        public let newsRepository: NewsRepositoryProtocol

        public init(
            strategy: Strategy,
            newsRepository: NewsRepositoryProtocol
        ) {
            self.strategy = strategy
            self.newsRepository = newsRepository
        }
    }

    public enum Strategy {
        ///  Latest stories
        case new
        /// Highly ranked stories
        case popular
    }

    private let dependency: Dependency

    public init(dependency: Dependency) {
        self.dependency = dependency
    }

    public func fetchIDs() async throws -> [Story.ID] {
        try await dependency.newsRepository.fetchStoryIDs(strategy: dependency.strategy)
    }
}

/// Interface of functions to access api resources
public protocol NewsRepositoryProtocol {
    func fetchStoryIDs(strategy: NewsListUseCase.Strategy) async throws -> [Story.ID]
}
