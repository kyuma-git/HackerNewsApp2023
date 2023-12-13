//
//  Story.swift
//  Domain
//
//  Created by Kyuma Morita on 2023/12/10.
//

/// News story
public struct Story: Identifiable, Hashable {
    public struct ID: Hashable {
        public let value: Int
        public init(value: Int) {
            self.value = value
        }
    }

    public let id: ID
    public let authorName: String
    public let title: String
    public let url: URL?
    public let score: Int

    public init(id: ID, authorName: String, title: String, url: URL?, score: Int) {
        self.id = id
        self.authorName = authorName
        self.title = title
        self.url = url
        self.score = score
    }
}
