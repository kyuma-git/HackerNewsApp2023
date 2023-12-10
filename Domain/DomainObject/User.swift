//
//  User.swift
//  Domain
//
//  Created by Kyuma Morita on 2023/12/10.
//

public struct User: Identifiable, Hashable {
    public struct ID: Hashable {
        public let value: String
        public init(value: String) {
            self.value = value
        }
    }

    public let id: ID
    public let name: String
    public let about: String
    public let karma: Int
    public let createdAt: Date

    public init(id: ID, name: String, about: String, karma: Int, createdAt: Date) {
        self.id = id
        self.name = name
        self.about = about
        self.karma = karma
        self.createdAt = createdAt
    }
}
