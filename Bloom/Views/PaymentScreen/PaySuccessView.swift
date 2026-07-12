//
//  PaySuccess.swift
//  Bloom
//
//  Created by Rendi Septrian on 04/07/26.
//

import SwiftUI

struct PaySuccessView: View {
    let booking: Booking
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
            BookingDetailView(booking: booking).navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    let appState = AppState()
    let booking = Booking(
        vendingMachine: appState.vendingMachines[0],
        date: Date(),
        totalPrice: 15000,
        status: .readyForPickup
    )
    return NavigationStack {
        PaySuccessView(booking: booking)
            .environment(appState)
    }
}
