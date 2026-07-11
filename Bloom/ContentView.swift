//
//  ContentView.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 29/06/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(AppState.self) var appState
    
    var body: some View {
        @Bindable var bindableAppState = appState
        TabView(selection: $bindableAppState.selectedTab) {
            // TAB 1: HOME
            NavigationStack {
                HomeView(appState: appState)
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(0)
            
            // TAB 2: MAP (Full Screen Map)
            NavigationStack {
                MapView(appState: appState)
            }
            .tabItem {
                Label("Map", systemImage: "map.fill")
            }
            .tag(1)

            NavigationStack {
                BookingView(appState: appState)
            }
            .tabItem {
                Label("Booking", systemImage: "cart.fill")
            }
            .tag(2)
            
            // TAB 3: PROFILE (Sebagai contoh jika nanti ditambahkan)
            NavigationStack {
                Text("Profile Screen") // Nanti diganti dengan ProfileView()
                    .navigationTitle("Profile")
            }
            .tabItem {
                Label("Profile", systemImage: "person.fill")
            }
            .tag(3)
        }
        .tint(.pink) // Mengubah warna ikon aktif di Tab Bar (sesuai tema Bloom)
    }
}

#Preview {
    ContentView()
        .environment(AppState())
}
