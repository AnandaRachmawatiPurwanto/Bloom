//
//  ProductDetails.swift
//  Bloom
//

import SwiftUI

struct ProductDetails: View {
    @Environment(\.dismiss) var dismiss

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
                            Text("The Breeze")
                                .font(.AppTheme.sectionTitle)
                                .foregroundColor(.black)
                            
                            Text("Green Park Office")
                                .font(.system(size: 22, weight: .regular))
                                .foregroundColor(.secondary)
                        }
                        
                        // Distance, Walking, and Status row
                        HStack {
                            HStack(spacing: 16) {
                                DistanceComponent(value: "120m away", type: .distance)
                                DistanceComponent(value: "5 mins", type: .walking)
                            }
                            
                            Spacer()
                            
                            AvailableCard()
                        }
                        
                        // Available Products Grid Card
                        ProductList(products: ["Regular Pad", "Wings Pad", "Pantyliner", "Night Pad"])
                        
                        // Action Buttons
                        HStack(spacing: 12) {
                            BloomButton(
                                "Get Direction",
                                iconName: "paperplane.fill",
                                style: .outlined,
                                maxWidth: true
                            ) {
                                print("Get Direction Tapped")
                            }
                            
                            BloomButton(
                                "Book",
                                style: .filled,
                                maxWidth: true
                            ) {
                                print("Book Tapped")
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
    }
}

#Preview {
    ProductDetails()
}

