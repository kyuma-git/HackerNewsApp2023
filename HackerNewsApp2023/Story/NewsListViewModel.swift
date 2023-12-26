//
//  NewsListViewModel.swift
//  HackerNewsApp2023
//
//  Created by Kyuma Morita on 2023/12/12.
//

import Combine
import Utility
import Domain
import Infra

@MainActor
final class NewsListViewModel: ObservableObject {

    @Published var uiState: UIState<NewsListViewObject> = .initial
    @Published var selectedStoryURL: IdentifiableURL?
    @Published var showDialog = false
    @Published var dialogMessage: String = ""

    private let  newsListSubject = PassthroughSubject<[Story], Never>()
    private var cancellable = Set<AnyCancellable>()

    var newsList: AnyPublisher<[Story], Never> {
        newsListSubject.eraseToAnyPublisher()
    }

    private let useCase: NewsListUseCase

    init(strategy: NewsListUseCase.Strategy) {
        useCase = NewsListUseCase(dependency: .init(
            strategy: strategy,
            newsRepository: NewsRepository()
        ))

        setupBindings()
    }

    func onAppear() {
        Task {
            do {
                uiState = .loading
                try await fetch()
            } catch {
                updateMessageAndShowDialog(newMessage: "Faild to fetch contents.")
            }
        }
    }

    func onTapStory(url: URL?) {
        if let url = url {
            selectedStoryURL = IdentifiableURL(url: url)
        } else {
            updateMessageAndShowDialog(newMessage: "Faild to show webpage. Please try again later.")
        }
    }

    private func setupBindings() {
        newsListSubject
            .receive(on: RunLoop.main)
            .sink { [weak self] items in
                guard let strongSelf = self else { return }
                // Order an Array of Story in descending date order.
                let sortedStories: [Story] = items.sorted { $0.createdAt > $1.createdAt }

                self?.uiState = .loaded(NewsListViewObject(
                    strategy: strongSelf.useCase.dependency.strategy,
                    items: sortedStories.map { StoryViewObject(domainObject: $0) }
                ))
            }
            .store(in: &cancellable)
    }

    func fetch() async throws {
        do {
            let response = try await useCase.fetchStories()
            newsListSubject.send(response)
        } catch {
            print("Failed to fetch news stories: \(error.localizedDescription)")
            throw error
        }
    }

    func updateMessageAndShowDialog(newMessage: String) {
        dialogMessage = newMessage
        showDialog = true
    }
}
