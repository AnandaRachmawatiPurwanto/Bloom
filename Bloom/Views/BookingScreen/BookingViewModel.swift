//
//  BookingViewModel.swift
//  Bloom
//

import SwiftUI
import Observation

@Observable class BookingViewModel {
    var bookings: [Booking] {
        appState.bookings
    }
    
    var activeBookings: [Booking] {
        return bookings.filter { $0.status == .readyForPickup }
    }
    
    var pastBookings: [Booking] {
        return bookings.filter { $0.status == .collected || $0.status == .paymentFailed }
    }
    
    private let appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    func collectBooking(_ booking: Booking) {
        guard let index = appState.bookings.firstIndex(where: { $0.id == booking.id }) else { return }
        appState.bookings[index].status = .collected
    }
    
    func failBooking(_ booking: Booking) {
        guard let index = appState.bookings.firstIndex(where: { $0.id == booking.id }) else { return }
        appState.bookings[index].status = .paymentFailed
    }
}
