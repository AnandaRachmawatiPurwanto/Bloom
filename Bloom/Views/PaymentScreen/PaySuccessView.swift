//
//  PaySuccess.swift
//  Bloom
//
//  Created by Rendi Septrian on 04/07/26.
//

import SwiftUI

struct PaySuccessView: View {
    @Environment(AppState.self) var appState

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
                appState.isShowingBookingDetailFromCheckout = true
                appState.selectedTab = 1 // Tab Booking adalah tag 1
                appState.isShowingProductsListHome = false // Reset Home NavigationStack ke root
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
    PaySuccessView()
        .environment(AppState())
}
