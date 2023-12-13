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
                    switch viewModel.viewData {
                    case .loaded(let ids):
                        VStack(alignment: .leading) {
                            Text("First news article: \(ids.count)")
                        }
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
