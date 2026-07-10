//
//  ProductsViewModel.swift
//  Bloom
//

import SwiftUI
import Combine

class ProductsViewModel: ObservableObject {
    @Published var selectedVendingMachine: VendingMachine? = nil
    @Published var selectedProduct: VendingMachineProduct? = nil
    @Published var selectedQuantity: Int = 1
    
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
    
    var hasSelection: Bool {
        selectedProduct != nil
    }
    
    var checkoutText: String {
        selectedProduct == nil ? "Select a product" : "Checkout"
    }
    
    var checkoutItemCountText: String {
        selectedProduct == nil ? "" : "\(selectedQuantity) Item"
    }
    
    var products: [VendingMachineProduct] {
        return selectedVendingMachine?.products ?? []
    }
    
    var availableProducts: [String] {
        guard let products = selectedVendingMachine?.products else {
            return ["Regular Pad", "Wings Pad", "Pantyliner", "Night Pad"]
        }
        let active = products.filter { $0.stock > 0 }.map { $0.name }
        return active.isEmpty ? ["Regular Pad", "Wings Pad", "Pantyliner", "Night Pad"] : active
    }
    
    var isAvailable: Bool {
        return selectedVendingMachine?.isAvailable ?? true
    }
    
    var distance: String {
        return selectedVendingMachine?.distance ?? "120m away"
    }
    
    var duration: String {
        return selectedVendingMachine?.duration ?? "5 mins"
    }
    
    var machineName: String {
        return selectedVendingMachine?.name ?? "The Breeze"
    }
    
    var machineSubtitle: String {
        return selectedVendingMachine?.subtitle ?? "Green Park Office"
    }
    
    func getDirection() {
        guard let appState = appState, let machine = selectedVendingMachine else { return }
        appState.routeDestination = machine.coordinate
        appState.routeDestinationName = machine.name
        appState.selectedTab = 1 // Switch to Map tab
    }
}
