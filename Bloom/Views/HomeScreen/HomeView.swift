//
//  HomeView.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 01/07/26.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .leading, spacing: 28) {
                
                // MARK: Greeting
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text("Hello, \(viewModel.userName)")
                        .font(.system(size: 42, weight: .bold))
                    
                    Text(viewModel.greetingMessage)
                        .font(.system(size: 24, weight: .regular))
                    
                }
                
                Divider()
                
                // MARK: Character
                
                //                Image("EmptyHome")
                //                    .resizable()
                //                    .scaledToFit()
                //                    .frame(maxWidth: .infinity)
                //                    .frame(height: 280)
                //                    .padding (.trailing, 10)
                ZStack{
                    MapView()
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
                
                // MARK: Card
                VStack(spacing: 16) {
                    ForEach(viewModel.vendingMachines) { machine in
                        LocationCard(vendingMachine: machine)
                    }
                }
                
            }
            .padding(.horizontal, 25)
            .padding(.top, 20)
            .padding(.bottom, 120)
            
        }
        .background(Color.AppTheme.mainBackground)
        .onAppear {
            viewModel.setup(appState: appState)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AppState())
}
#Preview {
    HomeView()
        .environmentObject(AppState())
}
