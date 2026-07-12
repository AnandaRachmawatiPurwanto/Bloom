//
//  LocationCard.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 01/07/26.
//

import SwiftUI
import CoreLocation

struct LocationCard: View {
    @Environment(AppState.self) var appState
    let vendingMachine: VendingMachine
    
    // Hitung jarak & durasi perjalanan secara dinamis dari GPS terkini user di AppState
    private var dynamicDistanceAndDuration: (distance: String, duration: String) {
        guard let userCoordinate = appState.locationManager.userLocation else {
            return (vendingMachine.distance, vendingMachine.duration) // Fallback data mock-up jika GPS mati
        }
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        let machineLocation = CLLocation(latitude: vendingMachine.coordinate.latitude, longitude: vendingMachine.coordinate.longitude)
        
        let distanceInMeters = userLocation.distance(from: machineLocation)
        
        // Format string jarak
        let distanceString: String
        if distanceInMeters < 1000 {
            distanceString = String(format: "%.0fm away", distanceInMeters)
        } else {
            distanceString = String(format: "%.1fkm away", distanceInMeters / 1000.0)
        }
        
        // Hitung Durasi Jalan kaki (rata-rata kecepatan jalan kaki: ~1.4 m/detik)
        let durationInMinutes = Int(distanceInMeters / (1.4 * 60))
        let durationString = durationInMinutes > 0 ? "\(durationInMinutes) mins" : "1 min"
        
        return (distanceString, durationString)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // Header: Judul & Status Ketersediaan
            HStack {
                Text(vendingMachine.name)
                    .font(.AppTheme.sectionTitle)
                
            }
            
            // Info Jarak & Waktu Tempuh (Dihitung dinamis menggunakan GPS)
            HStack(spacing: 24) {
                let info = dynamicDistanceAndDuration
                DistanceComponent(
                    value: info.distance,
                    type: .distance
                )
                
                DistanceComponent(
                    value: info.duration,
                    type: .walking
                )
            }
            
            // Tombol Aksi
            HStack(spacing: 12) {
                BloomButton(
                    "View Details",
                    style: .outlined
                ) {
                    appState.selectedVendingMachine = vendingMachine
                    appState.isShowingDetailsSheet = true
                }
                
                BloomButton(
                    "Choose Pad"
                ) {
                    appState.selectedVendingMachine = vendingMachine
                    appState.isShowingProductsList = true
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
            appState.selectedVendingMachine = vendingMachine
            appState.isShowingDetailsSheet = true // Ketika kartu diklik, langsung memicu sheet
        }
    }
}

#Preview {
    NavigationStack {
        LocationCard(vendingMachine: AppState().vendingMachines[0])
            .environment(AppState())
    }
}
