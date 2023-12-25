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

    /// The item's unique id.
    public let id: ID
    /// The username of the item's author.
    public let authorName: String
    /// The title of the story
    public let title: String
    /// The URL of the story
    public let url: URL
    /// The story's score
    public let score: Int
    /// Creation date of the item
    public let createdAt: Date

    public init(id: ID, authorName: String, title: String, url: URL, score: Int, createdAt: Date) {
        self.id = id
        self.authorName = authorName
        self.title = title
        self.url = url
        self.score = score
        self.createdAt = createdAt
    }
}

public enum StoryError: Error {
    case invalidURL
}
