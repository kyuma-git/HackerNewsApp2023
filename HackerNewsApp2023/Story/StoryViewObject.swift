//
//  StoryViewObject.swift
//  HackerNewsApp2023
//
//  Created by Kyuma Morita on 2023/12/12.
//

import Domain
import Utility

struct NewsListViewObject {
    let headerText: String
    let items: [StoryViewObject]

    init(strategy: NewsListUseCase.Strategy, items: [StoryViewObject]) {
        switch strategy {
        case .new:
            self.headerText = "Latest Stories"
        case .popular:
            self.headerText = "Highly ranked stories"
        }
        self.items = items
    }
}

struct IdentifiableURL: Identifiable {
    let id = UUID()
    let url: URL
}

struct StoryViewObject: Identifiable {
    let id: Story.ID
    let authorName: String
    let title: String
    let url: URL
    let score: Int
    let createdAt: String
    
    init(id: Story.ID, authorName: String, title: String, url: URL, score: Int, createdAt: String) {
        self.id = id
        self.authorName = authorName
        self.title = title
        self.url = url
        self.score = score
        self.createdAt = createdAt
    }

    init(domainObject: Story) {
        self.id = domainObject.id
        self.authorName = domainObject.authorName
        self.title = domainObject.title
        self.url = domainObject.url
        self.score = domainObject.score
        self.createdAt = DatePresenter(date: domainObject.createdAt).simpleDate
    }
}
