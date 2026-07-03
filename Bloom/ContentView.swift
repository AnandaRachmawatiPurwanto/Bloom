//
//  ContentView.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 29/06/26.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // TAB 1: HOME
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(0)
            
            // TAB 2: MAP (Full Screen Map)
            NavigationStack {
                MapView()
            }
            .tabItem {
                Label("Map", systemImage: "map.fill")
            }
            .tag(1)
            
            // TAB 3: PROFILE (Sebagai contoh jika nanti ditambahkan)
            NavigationStack {
                Text("Profile Screen") // Nanti diganti dengan ProfileView()
                    .navigationTitle("Profile")
            }
            .tabItem {
                Label("Profile", systemImage: "person.fill")
            }
            .tag(2)
        }
        .tint(.pink) // Mengubah warna ikon aktif di Tab Bar (sesuai tema Bloom)
    }
}
