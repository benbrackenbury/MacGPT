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
        if reload {
            view.reload()
            DispatchQueue.main.async {
                self.reload = false
            }
        }
    }
}

struct ContentView: View {
    @State private var shouldRefresh = false
    @AppStorage("showToolbar") var showToolbar = true
    
    var body: some View {
        ZStack{
            reloadButton
                .keyboardShortcut("r", modifiers: .command)
            openInBrowserButton
                .keyboardShortcut("o", modifiers: [.command, .shift])
            toggleToolbarButton
                .keyboardShortcut("t", modifiers: [.command, .option])
            VStack {
                if showToolbar {
                    HStack {
                        openInBrowserButton
                        Spacer()
                        reloadButton
                            .labelStyle(.iconOnly)
                        settingsButton
                            .labelStyle(.iconOnly)
                    }
                    .padding(.top)
                    .padding(.horizontal)
                }
                WebView(reload: $shouldRefresh)
            }
        }
        .frame(width: 350, height: 600)
    }
    
    var toggleToolbarButton: some View {
        Button(action: {
            withAnimation {
                showToolbar.toggle()
            }
        }) {
            Label("Toggle toolbar", systemImage: "menubar.rectangle")
        }
    }
    
    var openInBrowserButton: some View {
        Button(action: {
            let url = URL(string: "https://chat.openai.com")!
            NSWorkspace.shared.open(url)
        }) {
            Label("Open in Browser", systemImage: "globe")
        }
    }
    
    var reloadButton: some View {
        Button(action: {
            shouldRefresh = true
        }) {
            Label("Reload", systemImage: "arrow.clockwise")
        }
    }
    
    var settingsButton: some View {
        Button(action: {
            NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
        }) {
            Label("Settings", systemImage: "gear")
        }
    }
}
