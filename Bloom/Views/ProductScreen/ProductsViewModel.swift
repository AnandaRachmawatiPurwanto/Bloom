//
//  ProductsViewModel.swift
//  Bloom
//

import SwiftUI
import Observation

@Observable class ProductsViewModel {
    var selectedVendingMachine: VendingMachine? {
        appState.selectedVendingMachine
    }
    
    var selectedProduct: VendingMachineProduct? {
        appState.selectedProduct
    }
    
    var selectedQuantity: Int {
        appState.selectedQuantity
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
    
    private let appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    func getDirection() {
        guard let machine = selectedVendingMachine else { return }
        appState.routeDestination = machine.coordinate
        appState.routeDestinationName = machine.name
        appState.selectedTab = 1 // Switch to Map tab
    }
}
