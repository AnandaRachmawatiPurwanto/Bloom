//
//  BloomApp.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 29/06/26.
//

import SwiftUI
import FirebaseCore

@main
struct BloomApp: App {
    @State private var appState = AppState()
    @State private var isShowingSplash = true
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if isShowingSplash {
                    SpashScreen()
                        .transition(.opacity)
                } else {
                    ContentView()
                        .environment(appState)
                        .transition(.opacity)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isShowingSplash = false
                    }
                }
            }
        }
    }
}

