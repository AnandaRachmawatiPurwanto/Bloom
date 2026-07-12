//
//  HomeView.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 01/07/26.
//

import SwiftUI

struct HomeView: View {
    @Environment(AppState.self) var appState
    @State private var viewModel: HomeViewModel
    
    init(appState: AppState) {
        _viewModel = State(initialValue: HomeViewModel(appState: appState))
    }
    
    var body: some View {
        @Bindable var bindableAppState = appState
        
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .leading, spacing: 28) {
                
                // MARK: Greeting
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text("Hello, \(viewModel.userName)") // <-- Menggunakan ViewModel
                        .font(.system(size: 42, weight: .bold))
                    
                    Text(viewModel.greetingMessage) // <-- Menggunakan ViewModel
                        .font(.system(size: 24, weight: .regular))
                    
                }
                
                Divider()
                
                // MARK: Character & Map
                ZStack {
                    MapView(appState: appState)
                        .frame(height: 320)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.AppTheme.secondPink, lineWidth: 5)
                        )
                }
                
                // MARK: Nearby
                HStack {
                    Text("Bloom Nearby")
                        .font(.AppTheme.sectionHeader)
                        .foregroundStyle(.secondary)
                }
                
                // MARK: Card Vending Machines
                VStack(spacing: 16) {
                    ForEach(viewModel.vendingMachines) { machine in // <-- Menggunakan ViewModel
                        LocationCard(vendingMachine: machine)
                    }
                }
            }
            .padding(.horizontal, 25)
            .padding(.top, 20)
            .padding(.bottom, 120)
            
        }
        .background(Color.AppTheme.mainBackground)
        .sheet(isPresented: $bindableAppState.isShowingDetailsSheet, onDismiss: {
            if !appState.isShowingProductsList {
                appState.selectedVendingMachine = nil
            }
        }) {
            ProductDetailsView(appState: appState)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
        .navigationDestination(isPresented: $bindableAppState.isShowingProductsList) {
            ProductsView(appState: appState)
        }
    }
}

#Preview {
    HomeView(appState: AppState())
        .environment(AppState())
}
