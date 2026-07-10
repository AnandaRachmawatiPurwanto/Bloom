//
//  CheckoutViewModel.swift
//  Bloom
//

import SwiftUI
import Combine

class CheckoutViewModel: ObservableObject {
    @Published var selectedVendingMachine: VendingMachine? = nil
    @Published var selectedProduct: VendingMachineProduct? = nil
    @Published var selectedQuantity: Int = 1
    @Published var selectedPayment: PaymentType? = nil
    @Published var navigateToSuccess = false
    @Published var navigateToFailed = false
    @Published var isProcessing = false
    
    private var appState: AppState?
    private var cancellables = Set<AnyCancellable>()
    
    func setup(appState: AppState) {
        self.appState = appState
        
        // Sync selected vending machine from AppState
        appState.$selectedVendingMachine
            .sink { [weak self] machine in
                self?.selectedVendingMachine = machine
            }
            .store(in: &cancellables)
            
        // Sync selected product from AppState
        appState.$selectedProduct
            .sink { [weak self] product in
                self?.selectedProduct = product
            }
            .store(in: &cancellables)
            
        // Sync selected quantity from AppState
        appState.$selectedQuantity
            .sink { [weak self] qty in
                self?.selectedQuantity = qty
            }
            .store(in: &cancellables)
    }
    
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
            if let appState = self.appState, let machine = self.selectedVendingMachine {
                let newBooking = Booking(
                    vendingMachine: machine,
                    date: Date(),
                    totalPrice: self.totalPrice,
                    status: .readyForPickup
                )
                appState.bookings.append(newBooking)
            }
            
            self.navigateToSuccess = true
        }
    }
    
}
