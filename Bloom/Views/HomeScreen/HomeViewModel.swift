//
//  HomeViewModel.swift
//  Bloom
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var userName: String = "Fiona"
    @Published var vendingMachines: [VendingMachine] = []
    
    var greetingMessage: String {
        return "Need to find pads?"
    }
    
    private var appState: AppState?
    private var cancellables = Set<AnyCancellable>()
    
    func setup(appState: AppState) {
        self.appState = appState
        
        // Sync the vending machines from AppState
        appState.$vendingMachines
            .sink { [weak self] machines in
                self?.vendingMachines = machines
            }
            .store(in: &cancellables)
    }
}
