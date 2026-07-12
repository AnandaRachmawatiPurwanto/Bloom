//
//  ProductDetails.swift
//  Bloom
//

import SwiftUI
import MapKit

struct ProductDetailsView: View {
    @Environment(AppState.self) var appState
    @State private var viewModel: ProductsViewModel
    @Environment(\.dismiss) var dismiss
    @State private var isShowingProducts = false

    init(appState: AppState) {
        _viewModel = State(initialValue: ProductsViewModel(appState: appState))
    }

    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Header
            HStack {
                Spacer()
                Text("Details")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                Spacer()
            }
            .padding(.top, 16)
            .padding(.bottom, 8)
            
            // MARK: - Content ScrollView
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {

                    // Distance
                    HStack(spacing: 16) {
                        DistanceComponent(
                            value: viewModel.distance,
                            type: .distance
                        )

                        DistanceComponent(
                            value: viewModel.duration,
                            type: .walking
                        )
                    }

                    // Machine Name
                    Text(viewModel.machineName)
                        .font(.AppTheme.sectionTitle)

                    // Available Products
                    ProductList(products: viewModel.availableProducts)

                    // Buttons
                    HStack(spacing: 12) {

                        BloomButton(
                            "Get Direction",
                            iconName: "paperplane.fill",
                            style: .outlined,
                            maxWidth: true
                        ) {
                            viewModel.getDirection()
                            appState.isShowingDetailsSheet = false
                        }

                        BloomButton(
                            "Choose Pads",
                            style: .filled,
                            maxWidth: true
                        ) {
                            appState.isShowingDetailsSheet = false

                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                appState.isShowingProductsList = true
                            }
                        }
                    }

                    // Image slider paling bawah
                    ImageSlider()
                        .frame(height: 320)
                }
                .padding(.horizontal,20)
                .padding(.bottom,30)
            }
        }
        .background(Color.AppTheme.mainBackground)
    }
}

#Preview {
    ProductDetailsView(appState: AppState())
        .environment(AppState())
}


