//
//  HomeView.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 01/07/26.
//

import SwiftUI

struct HomeView: View {

    var body: some View {

        ScrollView(showsIndicators: false) {

            VStack(alignment: .leading, spacing: 28) {

                // MARK: Greeting
                VStack(alignment: .leading, spacing: 4) {
                    Text("Hello, Fiona")
                        .font(.system(size: 42, weight: .bold))

                    Text("Need to find pads?")
                        .font(.system(size: 24, weight: .regular))
                }

                Divider()

                // MARK: Character
                
                ZStack(alignment: .bottomTrailing) {
                    BloomMap()
                        .frame(height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.AppTheme.secondPink, lineWidth: 5)
                        )
                    
                    NavigationLink {
                        MapView()
                    } label: {
                        BloomIcon()
                            .padding(.bottom, 16)
                            .padding(.trailing, 16)
                    }
                }

                // MARK: Nearby
                VStack(alignment:.leading) {
                    Text("Bloom Nearby")
                        .font(.AppTheme.sectionHeader)
                        .foregroundStyle(.secondary)
                    
                    LocationCard()
                }

            }
            .padding(.horizontal, 25)
            .padding(.top, 20)
            .padding(.bottom, 120)

        }
        .background(Color.AppTheme.mainBackground)

    }
}

#Preview {
    HomeView()
}
