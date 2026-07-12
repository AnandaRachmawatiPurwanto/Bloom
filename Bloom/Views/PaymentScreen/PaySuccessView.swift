//
//  PaySuccess.swift
//  Bloom
//
//  Created by Rendi Septrian on 04/07/26.
//

import SwiftUI

struct PaySuccessView: View {
    @State private var navigateToDetail = false

    var body: some View {
        VStack {
            Spacer()
            Text("Payment Success")
                .font(.largeTitle)
                .padding()
            Image("success")
                .resizable()
                .scaledToFit()
                .frame(width: 124, height: 124)
                .padding()
            Spacer()
            BloomButton2 {
                navigateToDetail = true
            } content: {
                HStack {
                    Text("See Detail Booking")
                    
                }
            }
            .padding()
        }
        .navigationDestination(isPresented: $navigateToDetail) {
            BookingDetailView().navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    PaySuccessView()
        .environment(AppState())
}
