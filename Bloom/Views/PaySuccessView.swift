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
            ZStack {
                                Image(systemName: "seal.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color.red.opacity(0.2))
                                    .frame(width: 140, height: 140)
                                
                                Image(systemName: "xmark")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.red)
                                    .frame(width: 50, height: 50)
                                    .fontWeight(.bold)
                            }
            Spacer()
            BloomButton2 {
                print("Checkout Tapped")
            } content: {
                HStack {
                    Text("Retry")
                    
                }
            }
            .padding()
        }
    }
}

#Preview {
        PaySuccess()
}

