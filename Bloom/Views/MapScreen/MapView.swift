//
//  MapView.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 03/07/26.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Environment(AppState.self) var appState
    @State private var viewModel: MapViewModel
    
    init(appState: AppState) {
        _viewModel = State(initialValue: MapViewModel(appState: appState))
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            BloomMap(viewModel: viewModel)
            
            Button {
                viewModel.resetCameraToUserLocation()
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
    MapView(appState: AppState())
        .environment(AppState())
}
