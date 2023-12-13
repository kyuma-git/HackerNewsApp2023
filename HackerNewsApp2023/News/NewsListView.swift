//
//  NewsListView.swift
//  HackerNewsApp2023
//
//  Created by Kyuma Morita on 2023/12/11.
//

import SwiftUI
import Domain

public struct NewsListView: View {

    @StateObject private var viewModel: NewsListViewModel

    public init(strategy: NewsListUseCase.Strategy) {
        _viewModel = StateObject(wrappedValue: NewsListViewModel(strategy: strategy))
    }

    public var body: some View {
        NavigationStack {
            ScrollView {
                ZStack{
                    switch viewModel.uiState {
                    case .loaded(let viewData):
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
                                    viewModel.onTapStory(id: item.id)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    case .empty:
                        EmptyView()
                    case .loading:
                        EmptyView()
                    case .error:
                        EmptyView()
                    case .initial:
                        EmptyView()
                    }
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView(strategy: .new)
    }
}
