//
//  CardBooking.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 10/07/26.
//

import SwiftUI

struct CardBooking: View {

    let booking: Booking

    var body: some View {

        HStack(spacing: 16) {

            RoundedRectangle(cornerRadius: 18)
                .fill(.pink)
                .frame(width: 72, height: 72)
                .overlay {
                    Image("pads")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 42)
                }

            VStack(alignment: .leading) {

                Text(booking.vendingMachine.name)
                    .font(.title3.bold())

                Text(booking.date.formatted(date: .long, time: .omitted))
                    .foregroundStyle(.gray)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 8) {

                Text("Rp. \(Int(booking.totalPrice))")

                Text(booking.status.title)
                    .font(.caption.bold())
                    .padding(.horizontal,12)
                    .padding(.vertical,5)
                    .background(statusColor)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
            }

            Image(systemName: "chevron.right")
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    private var statusColor: Color {
        switch booking.status {
        case .readyForPickup:
            return .orange
        case .collected:
            return .green
        case .paymentFailed:
            return .red
        }
    }
}

