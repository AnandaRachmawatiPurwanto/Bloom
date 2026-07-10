//
//  Booking.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 10/07/26.
//
import Foundation

enum BookingStatus {
    case readyForPickup
    case collected
    case paymentFailed

    var title: String {
        switch self {
        case .readyForPickup:
            return "Ready For Pickup"
        case .collected:
            return "Collected"
        case .paymentFailed:
            return "Payment Failed"
        }
    }
}

struct Booking: Identifiable {
    let id = UUID()

    let vendingMachine: VendingMachine
    let date: Date
    let totalPrice: Double
    var status: BookingStatus
}

