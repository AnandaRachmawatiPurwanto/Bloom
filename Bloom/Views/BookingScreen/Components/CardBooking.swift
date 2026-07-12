//
//  CardBooking.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 10/07/26.
//

import SwiftUI
import CoreLocation

struct CardBooking: View {

    let booking: Booking

    var body: some View {

        HStack(spacing: 16) {

            RoundedRectangle(cornerRadius: 18)
                .fill(.pink)
                .frame(width: 53, height: 55)
                .overlay {
                    Image("Pads")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 35)
                }

            VStack(alignment: .leading) {

                Text(booking.vendingMachine.name)
                    .font(.title3.bold())

                Text(booking.date.formatted(date: .long, time: .omitted))
                    .foregroundStyle(.gray)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 10) {

                Text("Rp. \(Int(booking.totalPrice))")
                    .font(Font.body.bold())
                    .fixedSize(horizontal: true, vertical: false)


                Text(booking.status.title)
                    .font(.AppTheme.captionBold)
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(statusColor)
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

#Preview {
    CardBooking(
        booking: Booking(
            vendingMachine: VendingMachine(
                name: "The Breeze",
                subtitle: "Green Office Park",
                distance: "120m away",
                duration: "5 mins",
                isAvailable: true,
                coordinate: .init(latitude: -6.301, longitude: 106.652),
                products: [
                    VendingMachineProduct(
                        name: "Regular Pad",
                        imageName: "pads",
                        price: 10000,
                        stock: 10
                    )
                ]
            ),
            date: .now,
            totalPrice: 10000,
            status: .readyForPickup
        )
    )
    .padding()
    .background(Color(.systemGray6))
}
