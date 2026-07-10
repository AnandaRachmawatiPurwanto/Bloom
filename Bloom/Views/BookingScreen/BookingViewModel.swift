//
//  BookingViewModel.swift
//  Bloom
//

import SwiftUI
import Combine

class BookingViewModel: ObservableObject {
    @Published var bookings: [Booking] = []
    
    private var appState: AppState?
    private var cancellables = Set<AnyCancellable>()
    
    func setup(appState: AppState) {
        self.appState = appState
        
        // Sync bookings from AppState
        appState.$bookings
            .sink { [weak self] bookings in
                self?.bookings = bookings
            }
            .store(in: &cancellables)
    }
    
    var activeBookings: [Booking] {
        return bookings.filter { $0.status == .readyForPickup }
    }
    
    var pastBookings: [Booking] {
        return bookings.filter { $0.status == .collected || $0.status == .paymentFailed }
    }
    
    func collectBooking(_ booking: Booking) {
        guard let index = appState?.bookings.firstIndex(where: { $0.id == booking.id }) else { return }
        appState?.bookings[index].status = .collected
    }
    
    func failBooking(_ booking: Booking) {
        guard let index = appState?.bookings.firstIndex(where: { $0.id == booking.id }) else { return }
        appState?.bookings[index].status = .paymentFailed
    }
}
