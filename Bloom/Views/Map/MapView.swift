//
//  MapView.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 03/07/26.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var cameraPosition: MapCameraPosition = .region(.init(
            center: .bloomCentral,
            latitudinalMeters: 1500,
            longitudinalMeters: 1500
        ))
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            BloomMap()
            
            Button {
                withAnimation {
                    cameraPosition = .userLocation(fallback: .automatic)
                }
            } label: {
                Image(systemName: "location.fill")
                    .font(.title3)
                    .foregroundColor(.pink)
                    .frame(width: 44, height: 44)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
            }
            // Memberi sedikit jarak dari tepi layar
            .padding(.bottom, 16)
            .padding(.trailing, 16)
        }
    }
}

#Preview {
    MapView()
        .environmentObject(AppState())
}
