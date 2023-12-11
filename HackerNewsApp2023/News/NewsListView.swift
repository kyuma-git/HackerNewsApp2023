//
//  NewsListView.swift
//  HackerNewsApp2023
//
//  Created by Kyuma Morita on 2023/12/11.
//

import SwiftUI

public struct NewsListView: View {

    public init() {}

    public var body: some View {
        NavigationStack {
            ScrollView {
                ZStack{
                    VStack(alignment: .leading) {
                        ForEach(1..<21) { n in
                            Text("News article \(n)")
                        }
                    }
                }
            }
        }
    }
}
