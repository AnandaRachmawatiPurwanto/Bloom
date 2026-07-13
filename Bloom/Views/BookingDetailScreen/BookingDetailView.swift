//
//  BookingDetailView.swift
//  Bloom
//
//  Created by Rendi Septrian on 10/07/26.
//

import SwiftUI

struct BookingDetailView: View {
    let booking: Booking
    
    @State private var isSummaryExpanded: Bool = true
    @State private var viewModel: BookingDetailViewModel
    @Environment(AppState.self) var appState
    @Environment(\.dismiss) var dismiss
    @State private var navigateToMap = false
    
    init(booking: Booking) {
        self.booking = booking
        _viewModel = State(initialValue: BookingDetailViewModel(booking: booking))
    }
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    if viewModel.isCollected {
                        ImgCard(image: "success", title: "Collected")
                    } else {
                        QrCard(image: "qr", title: "Scan this QR code at the vending machine")
                    }
                    VStack {
                        LocCard(image: "loc", title: booking.vendingMachine.name, subtitle: booking.vendingMachine.subtitle)
                        
                        BloomButton2 {
                            appState.routeDestination = booking.vendingMachine.coordinate
                            appState.routeDestinationName = booking.vendingMachine.name
                            navigateToMap = true
                        } content: {
                            HStack {
                                Text("Get Directions")
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        
                        Button(action: {
                            withAnimation(.easeInOut) {
                                isSummaryExpanded.toggle()
                            }
                        }) {
                            HStack {
                                Image(systemName: isSummaryExpanded ? "chevron.up" : "chevron.down")
                                    .font(.title2)
                                    .foregroundColor(.primary)
                                
                                Text("Transaction Summary")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.primary)
                                
                                Spacer()
                            }
                        }
                        
                        if isSummaryExpanded {
                            let orderId = booking.id.uuidString.prefix(12).lowercased()
                            let productPrice = booking.totalPrice + 2000.0
                            let discount = 2000.0
                            
                            Text("Order ID : \(orderId) - \(formattedDate(booking.date))")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            CheckoutCard(image: "Pads", title: "Mastercard", subtitle: "**** **** **** 1234", amount: Int(booking.totalPrice))
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Summary")
                                    .font(.headline)
                                
                                HStack {
                                    Text("Product")
                                    Spacer()
                                    Text(formatRupiah(productPrice)) // Format otomatis
                                }
                                
                                HStack {
                                    Text("Discount (NEWUSER)")
                                    Spacer()
                                    Text("-\(formatRupiah(discount))")
                                        .foregroundStyle(.pink)
                                }
                                
                                Divider()
                                
                                HStack {
                                    Text("Total")
                                    Spacer()
                                    Text(formatRupiah(booking.totalPrice))
                                }
                                .font(.headline)
                                
                                HStack {
                                    Text("Payment")
                                    Spacer()
                                    HStack {
                                        Image(systemName: "applelogo")
                                        Text("Apple Pay")
                                    }
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .transition(.opacity.combined(with: .move(edge: .top)))
                        }
                    }
                    
                    if viewModel.isCollected {
                        BloomButton2 {
                            appState.selectedTab = 0
                            dismiss() // Pop back to bookings
                        } content: {
                            HStack {
                                Text("Buy Again")
                            }
                        }
                        .padding(.top, 16)
                    }
                }
                .padding()
            }
        }
        .navigationDestination(isPresented: $navigateToMap) {
            MapView(appState: appState)
        }
        .onAppear {
            viewModel.listenToFirebase(appState: appState)
        }
    }
    
    // MARK: - Helper fungsi
    
    // Fungsi untuk mengubah tipe data Date menjadi String yang rapi
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy - hh:mm a"
        return formatter.string(from: date)
    }
    
    // Fungsi untuk mengubah tipe data Double (angka) menjadi format mata uang Rupiah
    private func formatRupiah(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "IDR"
        formatter.maximumFractionDigits = 0 // Menghilangkan ,00 di belakang
        formatter.currencySymbol = "Rp. "
        
        return formatter.string(from: NSNumber(value: amount)) ?? "Rp. 0"
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
        BookingDetailView(booking: booking)
            .environment(appState)
    }
}
