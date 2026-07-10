//
//  VendingMachine.swift
//  Bloom
//
//  Created by Antigravity on 09/07/26.
//

import Foundation
import MapKit

struct VendingMachineProduct: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let imageName: String
    let price: Double
    var stock: Int
}

struct VendingMachine: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let subtitle: String
    let distance: String
    let duration: String
    let isAvailable: Bool
    let coordinate: CLLocationCoordinate2D
    let products: [VendingMachineProduct]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: VendingMachine, rhs: VendingMachine) -> Bool {
        lhs.id == rhs.id
    }
}


