//
//  Story.swift
//  Domain
//
//  Created by Kyuma Morita on 2023/12/10.
//

/// News story
public struct Story: Identifiable, Hashable {
    public struct ID: Hashable {
        public let value: String
        public init(value: String) {
            self.value = value
        }
    }

    public let id: ID
    public let authorName: String
    public let title: String
    public let text: String
    public let url: URL
    public let score: Int
    public let isDeleted: Bool
    public let isDead: Bool
    public let createdAt: Date

    public init(id: ID, authorName: String, title: String, text: String, url: URL, score: Int, isDeleted: Bool, isDead: Bool, createdAt: Date) {
        self.id = id
        self.authorName = authorName
        self.title = title
        self.text = text
        self.url = url
        self.score = score
        self.isDeleted = isDeleted
        self.isDead = isDead
        self.createdAt = createdAt
    }
}
