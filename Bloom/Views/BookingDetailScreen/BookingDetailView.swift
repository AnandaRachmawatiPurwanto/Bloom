//
//  BookingDetailView.swift
//  Bloom
//
//
//  Created by Rendi Septrian on 10/07/26.
//

import SwiftUI

struct BookingInfo {
    let orderId: String
    let date: Date
    let productPrice: Double
    let discount: Double
    
    var total: Double {
        return productPrice - discount
    }
}

struct BookingDetailView: View {
    let booking = BookingInfo(
        orderId: "1231938402af",
        date: Date(),
        productPrice: 100000,
        discount: 20000
    )
    
    @State private var isSummaryExpanded: Bool = true
    @State private var viewModel = BookingDetailViewModel()
    @Environment(AppState.self) var appState
    @Environment(\.dismiss) var dismiss
    
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
                        LocCard(image: "loc", title: "The Breeze", subtitle: "Green Office Park")
                        
                        BloomButton2 {
                            print("Tapped")
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
                        
                        // MARK: - logika dropdown disini
                        if isSummaryExpanded {
                            Text("Order ID : \(booking.orderId) - \(formattedDate(booking.date))")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            CheckoutCard(image: "pads", title: "Mastercard", subtitle: "**** **** **** 1234", amount: Int(booking.total))
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Summary")
                                    .font(.headline)
                                
                                HStack {
                                    Text("Product")
                                    Spacer()
                                    Text(formatRupiah(booking.productPrice)) // Format otomatis
                                }
                                
                                HStack {
                                    Text("Discount (NEWUSER)")
                                    Spacer()
                                    Text("-\(formatRupiah(booking.discount))")
                                        .foregroundStyle(.pink)
                                }
                                
                                Divider()
                                
                                HStack {
                                    Text("Total")
                                    Spacer()
                                    Text(formatRupiah(booking.total))
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
        .onAppear {
            viewModel.listenToFirebase()
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
    BookingDetailView()
        .environment(AppState())
}
