//
//  HomeView.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 01/07/26.
//

import SwiftUI

struct HomeView: View {
    @State private var isShowingAllNearby = false
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 28) {
                    
                    // MARK: Greeting
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Hello, Fiona")
                            .font(.system(size: 40, weight: .bold))
                        
                        Text("Need to find pads?")
                            .font(.system(size: 28, weight: .regular))
                    }
                    
                    Divider()
                    
                    // MARK: Character / Map Preview
                    ZStack(alignment: .bottomTrailing) {
                        BloomMap()
                            .frame(height: 220)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(Color.AppTheme.secondPink, lineWidth: 5)
                            )
                        
                        NavigationLink {
                            MapView()
                        } label: {
                            BloomIcon()
                                .padding(.bottom, 16)
                                .padding(.trailing, 16)
                        }
                    }
                    
                    // MARK: Nearby Section
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Bloom Nearby")
                                .font(.AppTheme.sectionHeader)
                                .foregroundStyle(.secondary)
                            
                            Spacer()
                            
                            Button(action: {
                                isShowingAllNearby = true
                            }) {
                                Text("View All")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.accentColor) // Sesuaikan warna tema
                            }
                        }

                        LocationCard()
                    }
                }
                .padding(.horizontal, 25)
                .padding(.top, 20)
                .padding(.bottom, 120)
            }
            .background(Color.AppTheme.mainBackground)
            // Navigasi opsional untuk tombol View All di masa depan
            .navigationDestination(isPresented: $isShowingAllNearby) {
                // Sediakan view list di sini jika ada, contoh: AllLocationsView()
                Text("All Locations List Screen")
            }
        }
    }
}

#Preview {
    HomeView()
}
