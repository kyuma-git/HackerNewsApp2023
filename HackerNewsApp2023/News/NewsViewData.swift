//
//  NewsViewData.swift
//  HackerNewsApp2023
//
//  Created by Kyuma Morita on 2023/12/12.
//

import Domain

struct NewsListViewData {
    let headerText: String
    let items: [Story]

    init(strategy: NewsListUseCase.Strategy, items: [Story]) {
        switch strategy {
        case .new:
            self.headerText = "Latest Stories"
        case .popular:
            self.headerText = "Highly ranked stories"
        }
        self.items = items
    }
}
