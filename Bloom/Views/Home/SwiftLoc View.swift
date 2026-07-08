//
//  SwiftLoc View.swift
//  Bloom
//

import SwiftUI
import MapKit

// 1. Model Data untuk menampung data lokasi secara rapi
struct BloomLocation: Identifiable {
    let id = UUID()
    let name: String
    let distance: String
    let duration: String
    let isAvailable: Bool
    let coordinate: CLLocationCoordinate2D
}

struct Swift_Loc_Swift_UIView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    
    // 2. State untuk teks pencarian
    @State private var searchText = ""
    
    // State untuk kontrol navigasi ke halaman detail / produk
    @State private var selectedLocation: BloomLocation? = nil
    @State private var isShowingDetails = false
    @State private var isShowingProducts = false
    
    // 3. Sumber data lokasi (Daftar lokasi)
    let locations = [
        BloomLocation(name: "The Breeze", distance: "120m away", duration: "5 mins", isAvailable: true, coordinate: .bloomCentral),
        BloomLocation(name: "AEON BSD", distance: "300m away", duration: "8 mins", isAvailable: true, coordinate: .bloomStation),
        BloomLocation(name: "Summarecon Mall", distance: "300m away", duration: "8 mins", isAvailable: true, coordinate: .bloomPlaza)
    ]
    
    // 4. Computed Property untuk memfilter lokasi berdasarkan ketikan pencarian
    var filteredLocations: [BloomLocation] {
        if searchText.isEmpty {
            return locations
        } else {
            return locations.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: - Custom Top Header (Navbar)
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 44, height: 44)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.08), radius: 6, x: 0, y: 3)
                }
                
                Spacer()
                
                Text("Bloom Location")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                
                Spacer()
                
                // Placeholder tidak terlihat agar teks judul tetap berada tepat di tengah
                Color.clear
                    .frame(width: 44, height: 44)
            }
            .padding(.horizontal)
            .padding(.top, 8)
            .padding(.bottom, 12)
            
            // MARK: - Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                
                TextField("Search bloom Location", text: $searchText)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                
                Image(systemName: "mic.fill")
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .background(Color(.systemGray6)) // Warna background abu-abu terang khas iOS
            .cornerRadius(12)
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
            
            // MARK: - Scrollable Location List
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(filteredLocations) { location in
                        
                        // KARTU LOKASI KUSTOM (Location Card)
                        VStack(alignment: .leading, spacing: 14) {
                            
                            // Baris 1: Nama Lokasi & Status Ketersediaan
                            HStack {
                                Text(location.name)
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                AvailableCard(style: location.isAvailable ? .available : .unavailable)
                            }
                            
                            // Baris 2: Informasi Jarak & Waktu Tempuh
                            HStack(spacing: 20) {
                                DistanceComponent(value: location.distance, type: .distance)
                                DistanceComponent(value: location.duration, type: .walking)
                            }
                            
                            // Baris 3: Tombol Aksi (HStack berisi 2 tombol berdampingan)
                            HStack(spacing: 12) {
                                BloomButton("View Details", style: .outlined) {
                                    selectedLocation = location
                                    isShowingDetails = true
                                }
                                
                                BloomButton("Book", style: .filled) {
                                    selectedLocation = location
                                    isShowingProducts = true
                                }
                            }
                        }
                        .padding(.vertical, 16)
                        .padding(.horizontal, 20)
                        .background(Color.white) // Latar belakang kartu putih bersih
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 4)
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.bottom, 24)
            }
        }
        .background(Color.AppTheme.mainBackground) // Latar belakang seluruh layar abu-abu iOS
        .navigationBarHidden(true)
        
        // MARK: - Navigation Triggers
        .navigationDestination(isPresented: $isShowingDetails) {
            ProductDetailsView()
        }
        .navigationDestination(isPresented: $isShowingProducts) {
            ProductsView()
        }
    }
}

#Preview {
    Swift_Loc_Swift_UIView()
        .environmentObject(AppState())
}

