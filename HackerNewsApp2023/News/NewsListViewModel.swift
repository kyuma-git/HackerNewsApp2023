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

    @Published var viewData: UIState<[String]> = .initial

    private let  newsListSubject = PassthroughSubject<[Story.ID], Never>()
    private var cancellable = Set<AnyCancellable>()

    var newsList: AnyPublisher<[Story.ID], Never> {
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

    func onTapStory(id: Story.ID) {
        // do something
    }

    private func setupBindings() {
        newsListSubject
            .receive(on: RunLoop.main)
            .sink { [weak self] news in
                self?.viewData = .loaded(
                    news.map {
                        String($0.value)
                    }
                )
            }
            .store(in: &cancellable)
    }

    func fetch() async throws {
        do {
            let response = try await useCase.fetchIDs()
            newsListSubject.send(response)
        } catch {
            print("Failed to fetch news stories")
        }
    }
}
