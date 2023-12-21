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

struct NewsListView: View {

    @StateObject private var viewModel: NewsListViewModel
    @State private var cancellables = Set<AnyCancellable>()

    public init(strategy: NewsListUseCase.Strategy) {
        _viewModel = StateObject(wrappedValue: NewsListViewModel(strategy: strategy))
    }

    public var body: some View {
        NavigationStack {
            switch viewModel.uiState {
            case .loaded(let viewData):
                VStack(alignment: .leading) {
                    ScrollView {
                        ForEach(viewData.items) { item in
                            VStack(alignment: .leading) {
                                HStack {
                                    // Because the API response does not include an image, place a sample image here
                                    AsyncImage(
                                        url: URL(string: "https://source.unsplash.com/random/300x200"),
                                        content: { image in
                                            image.resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 130, height: 80)
                                        },
                                        placeholder: {
                                            Image("placeholder_image")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 130, height: 80)
                                        }
                                    )
                                    VStack(alignment: .leading) {
                                        Text(item.title)
                                            .bold()
                                            .lineLimit(3)
                                        HStack {
                                            HStack {
                                                Image(systemName: "person.fill")
                                                Text(item.authorName)
                                                    .font(.system(size: 14))
                                                Spacer()
                                            }
                                            .foregroundColor(.gray)
                                            .frame(width: 130)
                                            HStack {
                                                Image(systemName: "hands.clap")
                                                Text(String(item.score))
                                                    .font(.system(size: 14))
                                            }
                                        }
                                    }
                                }
                                .frame(height: 100)
                                Divider()
                            }
                            .navigationTitle(viewData.headerText)
                            .navigationBarTitleDisplayMode(.inline)
                            .onTapGesture {
                                viewModel.onTapStory(url: item.url)
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            case .empty:
                VStack {
                    Spacer()
                    Text("No content exixt")
                    Spacer()
                }
            case .loading:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue)) // 任意の色に設定
                    .scaleEffect(2)
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
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
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
