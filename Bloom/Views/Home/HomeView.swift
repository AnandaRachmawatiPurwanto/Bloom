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

                Image("EmptyHome")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: 280)
                    .padding (.trailing, 10)

                // MARK: Nearby

                HStack {

                    Text("Bloom Nearby")
                        .font(.AppTheme.sectionHeader)
                        .foregroundStyle(.secondary)

                    Spacer()

                    BloomIcon()

                }

                // MARK: Card

                LocationCard()

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
#Preview {
    HomeView()
}
