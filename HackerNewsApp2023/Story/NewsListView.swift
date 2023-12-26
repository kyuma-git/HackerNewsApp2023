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
    @State var showDialog = false

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
                                    ).cornerRadius(5)
                                    VStack(alignment: .leading) {
                                        Text(item.title)
                                            .bold()
                                            .lineLimit(3)
                                        HStack {
                                            HStack(spacing: 4) {
                                                Image(systemName: "hands.clap")
                                                    .resizable()
                                                    .frame(width: 14, height: 14)
                                                Text(String(item.score))
                                                    .font(.system(size: 14))
                                            }
                                            HStack(spacing: 4) {
                                                Image(systemName: "person.fill")
                                                    .resizable()
                                                    .frame(width: 14, height: 14)
                                                Text(item.authorName)
                                                    .font(.system(size: 14))
                                                Spacer()
                                            }
                                            
                                            .lineLimit(1)
                                        }
                                        .foregroundColor(.gray)
                                        Text(item.createdAt)
                                            .font(.system(size: 14))
                                            .lineLimit(1)
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
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
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
        .alert(isPresented: $viewModel.showDialog) {
            Alert(title: Text("Message"), message: Text(viewModel.dialogMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView(strategy: .new)
    }
}
