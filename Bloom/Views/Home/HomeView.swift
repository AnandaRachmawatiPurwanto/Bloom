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
                    BloomIcon()
                        .alignmentGuide(VerticalAlignment.center) { _ in
                            -100
                        }
                       

                }
                

                // MARK: Nearby

                HStack {

                    Text("Bloom Nearby")
                        .font(.AppTheme.sectionHeader)
                        .foregroundStyle(.secondary)

                    Spacer()

                    BloomIcon()

                }

                // MARK: Card

                NavigationLink(destination: ProductsView()) {
                    LocationCard()
                }
                .buttonStyle(PlainButtonStyle()) // Agar warna font di kartu tidak berubah menjadi biru (warna default link)

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
        .environmentObject(AppState())
}
#Preview {
    HomeView()
}
