//
//  PaySuccess.swift
//  Bloom
//
//  Created by Rendi Septrian on 04/07/26.
//

import SwiftUI

struct PaySuccess: View {

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
    PaySuccess()
        .environment(AppState())
}
