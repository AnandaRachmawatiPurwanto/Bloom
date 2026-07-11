//
//  HomeViewModel.swift
//  Bloom
//

import SwiftUI
import Observation

@Observable class HomeViewModel {
    var userName: String = "Fiona"
    
    var greetingMessage: String {
        return "Need to find pads?"
    }
    
    var vendingMachines: [VendingMachine] {
        return appState.vendingMachines
    }
    
    private let appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
}
