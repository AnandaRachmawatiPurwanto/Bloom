//
//  BookingView.swift
//  Bloom
//

import SwiftUI

struct BookingView: View {
    @Environment(AppState.self) var appState
    @State private var viewModel: BookingViewModel
    @State private var selectedSegment = 0 // 0: On Going, 1: History
    
    init(appState: AppState) {
        _viewModel = State(initialValue: BookingViewModel(appState: appState))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Header Title
            Text("Bookings")
                .font(.system(size: 42, weight: .bold))
                .foregroundColor(.black)
                .padding(.horizontal, 25)
                .padding(.top, 20)
            
            // Segmented Picker
            Picker("", selection: $selectedSegment) {
                Text("On Going").tag(0)
                Text("History").tag(1)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 25)
            
            // Scrollable List of Cards
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    let bookings = selectedSegment == 0 ? viewModel.activeBookings : viewModel.pastBookings
                    
                    if bookings.isEmpty {
                        VStack(spacing: 12) {
                            Spacer()
                                .frame(height: 60)
                            Image(systemName: "doc.plaintext.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.gray.opacity(0.4))
                            Text("No bookings yet")
                                .font(.headline)
                                .foregroundColor(.gray)
                            Text(selectedSegment == 0 ? "You have no active orders." : "Your transaction history is empty.")
                                .font(.subheadline)
                                .foregroundColor(.gray.opacity(0.7))
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    } else {
                        ForEach(bookings) { booking in
                            CardBooking(booking: booking)
                        }
                    }
                }
                .padding(.horizontal, 25)
                .padding(.top, 8)
                .padding(.bottom, 120) // Give space for custom floating tab bar
            }
        }
        .background(Color.AppTheme.mainBackground)
    }
}



#Preview {
    BookingView(appState: AppState())
        .environment(AppState())
}
