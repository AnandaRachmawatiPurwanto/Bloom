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
        @Bindable var bindableAppState = appState
        
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
        .sheet(isPresented: Binding(
            get: { appState.isShowingDetailsSheet && appState.selectedTab == 1 },
            set: { appState.isShowingDetailsSheet = $0 }
        ), onDismiss: {
            if appState.shouldNavigateToProductsList {
                appState.shouldNavigateToProductsList = false
                appState.isShowingProductsListMap = true
            } else {
                appState.selectedVendingMachine = nil
            }
        }) {
            ProductDetailsView(appState: appState)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
        .navigationDestination(isPresented: $bindableAppState.isShowingProductsListMap) {
            ProductsView(appState: appState)
        }
    }
}

#Preview {
    MapView(appState: AppState())
        .environment(AppState())
}
