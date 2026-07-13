//
//  CheckoutViewModel.swift
//  Bloom
//

import SwiftUI
import Observation

@Observable class CheckoutViewModel {
    var selectedVendingMachine: VendingMachine? {
        appState.selectedVendingMachine
    }
    
    var selectedProduct: VendingMachineProduct? {
        appState.selectedProduct
    }
    
    var selectedQuantity: Int {
        appState.selectedQuantity
    }
    
    var selectedPayment: PaymentType? = nil
    var navigateToSuccess = false
    var navigateToFailed = false
    var isProcessing = false
    var createdBooking: Booking? = nil
    
    var productName: String {
        return selectedProduct?.name ?? "Regular Pad"
    }
    
    var productImageName: String {
        return selectedProduct?.imageName ?? "pads"
    }
    
    var quantityText: String {
        return "\(selectedQuantity) item\(selectedQuantity > 1 ? "s" : "")"
    }
    
    var productPrice: Double {
        return (selectedProduct?.price ?? 15000.0) * Double(selectedQuantity)
    }
    
    var discount: Double {
        return selectedProduct != nil ? 2000.0 : 0.0
    }
    
    var totalPrice: Double {
        return max(productPrice - discount, 0.0)
    }
    
    var machineName: String {
        return selectedVendingMachine?.name ?? "The Breeze"
    }
    
    var machineSubtitle: String {
        return selectedVendingMachine?.subtitle ?? "Green Office Park"
    }
    
    private let appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    func checkout() {
        guard selectedPayment != nil else {
            print("Pilih metode pembayaran terlebih dahulu!")
            return
        }
        
        isProcessing = true
        
        // Simulasikan delay pembayaran sukses (1 detik)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            self.isProcessing = false
            
            // Simulasikan pembuatan booking sukses
            if let machine = self.selectedVendingMachine {
                let newBooking = Booking(
                    vendingMachine: machine,
                    date: Date(),
                    totalPrice: self.totalPrice,
                    status: .readyForPickup
                )
                self.appState.bookings.append(newBooking)
                self.createdBooking = newBooking
                self.appState.checkoutCreatedBooking = newBooking
            }
            
            self.navigateToSuccess = true
        }
    }
}
