//
//  HackerNewsApp2023App.swift
//  HackerNewsApp2023
//
//  Created by Kyuma Morita on 2023/12/08.
//

import SwiftUI
import SwiftData

@main
struct HackerNewsApp2023App: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
