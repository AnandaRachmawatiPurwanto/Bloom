//
//  LocationCard.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 01/07/26.
//

import SwiftUI

struct LocationCard: View {
    @State private var isShowingDetails = false
    @State private var isShowingProducts = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // Header: Judul & Status Ketersediaan
            HStack {
                Text("The Breeze")
                    .font(.AppTheme.sectionTitle)
                
                Spacer()
                
                AvailableCard(style: .available)
            }
            
            // Info Jarak & Waktu Tempuh
            HStack(spacing: 24) {
                DistanceComponent(
                    value: "120 m away",
                    type: .distance
                )
                
                DistanceComponent(
                    value: "5 mins",
                    type: .walking
                )
            }
            
            // Tombol Aksi
            HStack(spacing: 12) {
                // Tombol View Details tetap ada, atau bisa kamu hapus/ganti kalau dirasa redundant
                BloomButton(
                    "View Details",
                    style: .outlined
                ) {
                    isShowingDetails = true
                }
                
                BloomButton(
                    "Book"
                ) {
                    isShowingProducts = true
                }
            }
        }
        // Styling untuk Kartu (VStack)
        .frame(maxWidth: 335, maxHeight: 145)
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .background(Color.AppTheme.secondPink)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
        .contentShape(RoundedRectangle(cornerRadius: 20)) // Memastikan area kosong di background juga sensitif klik
        .onTapGesture {
            isShowingDetails = true // Ketika kartu diklik, langsung memicu navigasi
        }
        
        // --- Navigasi Terpusat ---
        .navigationDestination(isPresented: $isShowingDetails) {
            ProductDetailsView()
        }
        .navigationDestination(isPresented: $isShowingProducts) {
            ProductsView()
        }
    }
}

#Preview {
    LocationCard()
        .environmentObject(AppState())
}

