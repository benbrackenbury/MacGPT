//
//  MacGPTApp.swift
//  MacGPT
//
//  Created by Ben Brackenbury on 28/02/2023.
//

import SwiftUI

@main
struct MacGPTApp: App {
    var body: some Scene {
        MenuBarExtra {
            ContentView()
        } label: {
            Label("MacGPT", systemImage: "waveform")
        }
        .menuBarExtraStyle(.window)
        .windowResizability(.contentMinSize)
    }
}
