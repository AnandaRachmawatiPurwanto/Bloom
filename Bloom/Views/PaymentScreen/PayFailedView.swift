//
//  PayFailedView.swift
//  Bloom
//
//  Created by Rendi Septrian on 04/07/26.
//


import SwiftUI


struct PayFailedView: View {
    @Environment(\.dismiss) var dismiss
    
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
                dismiss()
            } content: {
                HStack {
                    Text("Try Again")
                    
                }
            }
            .padding()
        }
    }
}

#Preview {
    PayFailedView()
        .environment(AppState())
}
