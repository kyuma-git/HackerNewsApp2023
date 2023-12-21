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

    public enum NewsListError: Error {
        case fetchError
    }

    public let dependency: Dependency

    public init(dependency: Dependency) {
        self.dependency = dependency
    }

    private func fetchIDs() async throws -> [Story.ID] {
        try await dependency.newsRepository.fetchStoryIDs(strategy: dependency.strategy)
    }

    public func fetchStories() async throws -> [Story] {
        let ids = try await fetchIDs()

        var stories: [Story] = []

        for id in ids.prefix(15) {
            do {
                let res = try await dependency.newsRepository.fetchStory(id: id)
                stories.append(res)
            } catch {
                print("Error fetching story for id \(id): \(error)")
                continue
            }
        }

        return stories
    }
}

/// Interface of functions to access api resources
public protocol NewsRepositoryProtocol {
    func fetchStoryIDs(strategy: NewsListUseCase.Strategy) async throws -> [Story.ID]
    func fetchStory(id: Story.ID) async throws -> Story
}
