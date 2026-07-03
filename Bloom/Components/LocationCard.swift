//
//  LocationCard.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 01/07/26.
//

import SwiftUI


struct LocationCard: View {
    @State private var isShowingDetails = false
    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            HStack {

                Text("The Breeze")
                    .font(.AppTheme.sectionTitle)

                Spacer()

                AvailableCard(style: .available)
            }

            HStack(spacing: 24) {

                DistanceComponent(
                    value: "120 m away",
                    type: .distance
                )

                DistanceComponent(
                    value: "5 mins",
                    type: .walking
                )
            }

            HStack(spacing: 12) {

                BloomButton(
                    "View Details",
                    style: .outlined
                ) {
                    isShowingDetails = true

                }

                BloomButton(
                    "Book"
                ) {

                }

            }
            

        }
        .frame(maxWidth: 335, maxHeight: 145)
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .background(Color.AppTheme.secondPink)
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
        .navigationDestination(isPresented: $isShowingDetails){
            ProductDetailsView()
        }
    }
}

#Preview {
    LocationCard()
}

#Preview {
    LocationCard()
}
