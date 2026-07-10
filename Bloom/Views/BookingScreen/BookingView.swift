//
//  BookingView.swift
//  Bloom
//

import SwiftUI

struct BookingView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = BookingViewModel()
    @State private var selectedSegment = 0 // 0: On Going, 1: History
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Header Title
            Text("Bookings")
                .font(.system(size: 42, weight: .bold))
                .foregroundColor(.black)
                .padding(.horizontal, 25)
                .padding(.top, 20)
            
            // Segmented Picker
            SegmentedControl(selectedSegment: $selectedSegment)
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
        .onAppear {
            viewModel.setup(appState: appState)
        }
    }
}

// Custom segment selector matching the design in the mockup
struct SegmentedControl: View {
    @Binding var selectedSegment: Int
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    selectedSegment = 0
                }
            }) {
                Text("On Going")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(selectedSegment == 0 ? .black : .gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        Group {
                            if selectedSegment == 0 {
                                Capsule()
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                            }
                        }
                    )
            }
            
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    selectedSegment = 1
                }
            }) {
                Text("History")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(selectedSegment == 1 ? .black : .gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        Group {
                            if selectedSegment == 1 {
                                Capsule()
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                            }
                        }
                    )
            }
        }
        .padding(4)
        .frame(height: 48)
        .background(Color(.systemGray6))
        .clipShape(Capsule())
    }
}

#Preview {
    BookingView()
        .environmentObject(AppState())
}
