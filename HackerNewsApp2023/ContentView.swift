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
        UITabBar.appearance().backgroundColor = UIColor(Color.white)
    }

    public var body: some View {
            TabView(selection: $selectedTab) {
                NewsListView()
                    .tabItem {
                        Text("Top")
                    }
                    .tag(0)
                NewsListView()
                    .tabItem {
                        Text("Popular")
                    }
                    .tag(1)
            }
            .accentColor(.orange)
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ContentView()
}
