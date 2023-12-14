//
//  NewsListUseCaseTests.swift
//  HackerNewsApp2023Tests
//
//  Created by Kyuma Morita on 2023/12/14.
//

import XCTest
@testable import Domain

class NewsListUseCaseTests: XCTestCase {

    func testFetchStoriesSuccess() async throws {
        let mockRepository = MockNewsRepository()
        mockRepository.fetchStoryIDsResult = .success([
            Story.ID(value: 1),
            Story.ID(value: 2),
            Story.ID(value: 3)
        ])
        mockRepository.fetchStoryResult = .success(
            Story(
                id: Story.ID(value: 1),
                authorName: "Sample author name",
                title: "Sample article title",
                url: URL(string: "https://www.twitter.com"),
                score: 5
            )
        )

        let useCase = NewsListUseCase(dependency: .init(strategy: .new, newsRepository: mockRepository))

        do {
            let stories = try await useCase.fetchStories()
            // Assert that the correct number of stories are fetched
            XCTAssertEqual(stories.count, 3)
        } catch {
            XCTFail("Fetching stories should not fail.")
        }
    }

    func testFetchStoriesFailure() async throws {
        let mockRepository = MockNewsRepository()
        mockRepository.fetchStoryIDsResult = .failure(NewsListUseCase.NewsListError.fetchError)

        let useCase = NewsListUseCase(dependency: .init(strategy: .popular, newsRepository: mockRepository))

        do {
            let _ = try await useCase.fetchStories()
            XCTFail("Fetching stories should fail.")
        } catch {
            // Assert the error type (WIP)
        }
    }
}

class MockNewsRepository: NewsRepositoryProtocol {
    var fetchStoryIDsResult: Result<[Story.ID], Error>?
    var fetchStoryResult: Result<Story, Error>?

    func fetchStoryIDs(strategy: NewsListUseCase.Strategy) async throws -> [Story.ID] {
        switch fetchStoryIDsResult {
        case .success(let ids):
            return ids
        case .failure(let error):
            throw error
        default:
            fatalError("Fetch story IDs result not set.")
        }
    }

    func fetchStory(id: Story.ID) async throws -> Story {
        switch fetchStoryResult {
        case .success(let story):
            return story
        case .failure(let error):
            throw error
        default:
            fatalError("Fetch story result not set.")
        }
    }
}

