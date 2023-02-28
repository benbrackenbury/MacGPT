//
//  ContentView.swift
//  MacGPT
//
//  Created by Ben Brackenbury on 28/02/2023.
//

import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {

    let view: WKWebView = WKWebView()

    var request: URLRequest {
        get{
            let url: URL = URL(string: "https://chat.openai.com")!
            let request: URLRequest = URLRequest(url: url)
            return request
        }
    }

    func makeNSView(context: Context) -> WKWebView {
        view.load(request)
        return view
    }

    func updateNSView(_ view: WKWebView, context: Context) {
        view.load(request)
    }

}

struct ContentView: View {

    var body: some View {
        WebView()
            .frame(width: 350, height: 600)
    }
}
