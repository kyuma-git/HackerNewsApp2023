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

final class NewsListViewModel: ObservableObject {

    enum Event {
        case showInternalWeb(url: URL)
    }

    @Published var uiState: UIState<NewsListViewData> = .initial
    @Published var selectedStoryURL: IdentifiableURL?

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
            try await fetch()
        }
    }

    func onTapStory(url: URL?) {
        if let url = url {
            selectedStoryURL = IdentifiableURL(url: url)
        } else {
            // show error dialong
        }
        
    }

    private func setupBindings() {
        newsListSubject
            .receive(on: RunLoop.main)
            .sink { [weak self] items in
                guard let strongSelf = self else { return }
                self?.uiState = .loaded(NewsListViewData(
                    strategy: strongSelf.useCase.dependency.strategy,
                    items: items
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
        }
    }
}
