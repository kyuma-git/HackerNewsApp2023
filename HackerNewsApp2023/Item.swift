//
//  Item.swift
//  HackerNewsApp2023
//
//  Created by Kyuma Morita on 2023/12/08.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
