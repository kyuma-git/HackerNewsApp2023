//
//  SafariView.swift
//  Utility
//
//  Created by Kyuma Morita on 2023/12/14.
//

import SafariServices
import SwiftUI

public struct SafariView: UIViewControllerRepresentable {

    public let url: URL

    public init(url: URL) {
        self.url = url
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    public func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        // Update the view controller if needed
    }
}
