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
    @Binding var reload: Bool

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
//        view.load(request)
        
        if reload {
            view.reload()
            DispatchQueue.main.async {
                self.reload = false     // must be async
            }
        }
    }
}

struct ContentView: View {
    @State private var shouldRefresh = false
    
    var body: some View {
        ZStack{
            Button(action: {
                shouldRefresh = true
            }) {
                Label("Reload", systemImage: "arrow.clockwise")
            }
            .keyboardShortcut("r", modifiers: .command)
            WebView(reload: $shouldRefresh)
        }
        .frame(width: 350, height: 600)
    }
}
