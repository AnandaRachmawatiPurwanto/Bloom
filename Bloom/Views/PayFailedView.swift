//
//  PayFailedView.swift
//  Bloom
//
//  Created by Rendi Septrian on 04/07/26.
//


import SwiftUI


struct PayFailed: View {
    
    
    var body: some View {
        VStack {
            Spacer()
            Text("Payment Failed")
                .font(.largeTitle)
                .padding()
            Image("failed")
                .resizable()
                .scaledToFit()
                .frame(width: 124, height: 124)
                .padding()
            Spacer()
            BloomButton2 {
                print("Checkout Tapped")
            } content: {
                HStack {
                    Text("See Detail Booking")
                    
                }
            }
            .padding()
        }
    }
}

#Preview {
        PayFailed()
}

