//
//  SettingsView.swift
//  MacGPT
//
//  Created by Ben Brackenbury on 01/03/2023.
//

import SwiftUI
import AppKit

struct SettingsView: View {
    @AppStorage("showToolbar") var showToolbar = true
    
    var body: some View {
        TabView {
            generalTab
            .tabItem {
                Label("General", systemImage: "gear")
            }
            keyboardShortcutsTab
            .tabItem {
                Label("Keyboard Shortcuts", systemImage: "keyboard")
            }
            aboutTab
            .tabItem {
                Label("About", systemImage: "info")
            }
        }
        .frame(width: 400, height: 200)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView {
    var generalTab: some View {
        Form {
            Toggle("Show toolbar", isOn: $showToolbar)
        }
    }
    
    var aboutTab: some View {
        Form {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 4) {
                    VStack(alignment: .leading){
                        Text("MacGPT")
                            .font(.title.weight(.bold))
                        Text("ChatGPT in your menu bar")
                    }
                    Text("Ben Brackenbury 2023")
                        .font(.caption.weight(.thin))
                }
                .padding(.bottom)
                VStack(alignment: .leading) {
                    LabeledContent("Version", value: Bundle.main.releaseVersionNumber ?? "unknown")
                    LabeledContent("Build", value: Bundle.main.buildVersionNumber ?? "unknown")
                }
                Spacer()
                HStack {
                    Button("View on GitHub") {
                        let url = URL(string: "https://github.com/benbrackenbury/MacGPT")!
                        NSWorkspace.shared.open(url)
                    }
                    Button("Twitter") {
                        let url = URL(string: "https://twitter.com/ben_brackenbury")!
                        NSWorkspace.shared.open(url)
                    }
                }
            }
            .padding()
            .fullSize()
        }
    }
        
    var keyboardShortcutsTab: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Keyboard Shortcuts")
                    .font(.title.weight(.bold))
                Spacer()
            }
            .padding()
            
            VStack {
                HStack {
                    Text("Reload")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("⌘R")
                        .fontWeight(.thin)
                }
                HStack {
                    Text("Open in browser")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("⇧⌘O")
                        .fontWeight(.thin)
                }
                HStack {
                    Text("Toggle toolbar")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("⌥⌘T")
                        .fontWeight(.thin)
                }
                HStack {
                    Text("Settings")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("⌘,")
                        .fontWeight(.thin)
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
}


extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}

struct FullSizeViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}

extension View {
    func fullSize() -> some View {
        modifier(FullSizeViewModifier())
    }
}
