//
//  ImageSlider.swift
//  Bloom
//

import SwiftUI

struct ImageSlider: View {

    let images = [
        "VM1",
        "VM2"
    ]

    var body: some View {

        TabView {

            ForEach(images, id: \.self) { image in

                ZStack {
                    Image(image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 10) // Silakan ganti angkanya sesuai kebutuhan desainmu
    
                    
                }
                .frame(width: 335, height: 250)
                //.background(Color.AppTheme.white)
                .clipped()
                .cornerRadius(24)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.AppTheme.activePink, lineWidth: 4)
                )
                .padding(.horizontal)
                
                //.background(Color.AppTheme.white)
                

            }

        }
        .frame(height: 320)
        .tabViewStyle(.page(indexDisplayMode: .always))
        

    }
}

#Preview {
    ImageSlider()
}

