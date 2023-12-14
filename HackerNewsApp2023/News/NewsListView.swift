//
//  NewsListView.swift
//  HackerNewsApp2023
//
//  Created by Kyuma Morita on 2023/12/11.
//

import SwiftUI
import Combine
import Domain
import Utility

public struct NewsListView: View {

    @StateObject private var viewModel: NewsListViewModel
    @State private var cancellables = Set<AnyCancellable>()

    public init(strategy: NewsListUseCase.Strategy) {
        _viewModel = StateObject(wrappedValue: NewsListViewModel(strategy: strategy))
    }

    public var body: some View {
        NavigationStack {
            switch viewModel.uiState {
            case .loaded(let viewData):
                ScrollView {
                    VStack(alignment: .leading) {
                        Text(viewData.headerText)
                            .bold()
                            .font(.system(size: 20))
                            .lineLimit(3)
                            .padding(.bottom, 20)
                        ForEach(viewData.items) { item in
                            VStack(alignment: .leading) {
                                Text(item.title)
                                HStack {
                                    Image(systemName: "person.fill")
                                    Text(item.authorName)
                                }
                                Divider()
                            }
                            .onTapGesture {
                                print("tapped \(item.id)")
                                viewModel.onTapStory(url: item.url)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
            case .empty:
                VStack {
                    Spacer()
                    Text("No content exixt")
                    Spacer()
                }
            case .loading:
                VStack {
                    Spacer()
                    Image(systemName: "slowmo")
                    Spacer()
                }
            case .error:
                VStack {
                    Spacer()
                    Text("Something went wrong")
                    Spacer()
                }
            case .initial:
                EmptyView()
            }
        }
        .sheet(item: $viewModel.selectedStoryURL, content: { identifiableURL in
            SafariView(url: identifiableURL.url)
        })
        .onAppear {
            viewModel.onAppear()
            viewModel.eventPublisher
                .receive(on: RunLoop.main)
                .sink { event in
                    switch event {
                    case .showInternalWeb(let url):
                        break
                    }
                }
                .store(in: &cancellables)
        }
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView(strategy: .new)
    }
}
