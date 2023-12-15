//
//  ContentView.swift
//  HackerNewsApp2023
//
//  Created by Kyuma Morita on 2023/12/08.
//

import SwiftUI

public struct ContentView: View {
    @State private var selectedTab = 0

    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color.gray.opacity(0.1))
    }

    public var body: some View {
            TabView(selection: $selectedTab) {
                NewsListView(strategy: .new)
                    .tabItem {
                        VStack {
                            Image(systemName: "newspaper.fill")
                            Text("Top Stories")
                        }
                    }
                    .tag(0)
                NewsListView(strategy: .popular)
                    .tabItem {
                        VStack {
                            Image(systemName: "hands.clap.fill")
                            Text("Popular")
                        }
                    }
                    .tag(1)
            }
            .accentColor(.blue)
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ContentView()
}
