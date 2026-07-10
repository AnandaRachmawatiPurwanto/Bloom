//
//  ProductDetails.swift
//  Bloom
//

import SwiftUI
import MapKit

struct ProductDetailsView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = ProductsViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var isShowingProducts = false

    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Custom Top Header
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
                
                Text("Details")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                
                Spacer()
                
                // Invisible placeholder to keep the title centered
                Color.clear
                    .frame(width: 44, height: 44)
            }
            .padding(.horizontal)
            .padding(.top, 8)
            .padding(.bottom, 12)
            
            // MARK: - Content ScrollView
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Image Slider (dots under image)
                    ImageSlider()
                        .frame(height: 320)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // Title and Subtitle
                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.machineName)
                                .font(.AppTheme.sectionTitle)
                                .foregroundColor(.black)
                            
                            Text(viewModel.machineSubtitle)
                                .font(.system(size: 22, weight: .regular))
                                .foregroundColor(.secondary)
                        }
                        
                        // Distance, Walking, and Status row
                        HStack {
                            HStack(spacing: 16) {
                                DistanceComponent(value: viewModel.distance, type: .distance)
                                DistanceComponent(value: viewModel.duration, type: .walking)
                            }
                            
                            Spacer()
                            
                            AvailableCard(style: viewModel.isAvailable ? .available : .unavailable)
                        }
                        
                        // Available Products Grid Card
                        ProductList(products: viewModel.availableProducts)
                        
                        // Action Buttons
                        HStack(spacing: 12) {
                            BloomButton(
                                "Get Direction",
                                iconName: "paperplane.fill",
                                style: .outlined,
                                maxWidth: true
                            ) {
                                viewModel.getDirection()
                                dismiss() // Dismiss details view
                            }
                            
                            BloomButton(
                                "Choose Pad",
                                style: .filled,
                                maxWidth: true
                            ) {
                                isShowingProducts = true
                            }
                        }
                        .padding(.top, 8)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 32)
            }
        }
        .background(Color.AppTheme.mainBackground)
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $isShowingProducts) {
            ProductsView() // <-- Layar tujuan saat tombol ditekan
        }
        .onAppear {
            viewModel.setup(appState: appState)
        }
    }
}

#Preview {
    ProductDetailsView()
        .environmentObject(AppState())
}


