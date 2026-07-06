//
//  BloomApp.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 29/06/26.
//

import SwiftUI

@main
struct BloomApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}

