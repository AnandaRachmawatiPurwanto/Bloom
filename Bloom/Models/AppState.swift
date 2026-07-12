//
//  AppState.swift
//  Bloom
//

import SwiftUI
import MapKit
import Observation

@Observable class AppState {
    var selectedTab: Int = 0
    var routeDestination: CLLocationCoordinate2D? = nil
    var routeDestinationName: String = ""
    
    let locationManager = LocationManager()
    
    var bookings: [Booking] = []
    
    var vendingMachines: [VendingMachine] = [
        VendingMachine(
            name: "The Breeze",
            subtitle: "Green Office Park",
            distance: "120m away",
            duration: "5 mins",
            isAvailable: true,
            coordinate: CLLocationCoordinate2D(latitude: -6.3024, longitude: 106.6522),
            products: [
                VendingMachineProduct(name: "Regular Pad", imageName: "pads", price: 15000, stock: 12),
                VendingMachineProduct(name: "Wings Pad", imageName: "pads", price: 18000, stock: 8),
                VendingMachineProduct(name: "Pantyliner", imageName: "pads", price: 12000, stock: 15),
                VendingMachineProduct(name: "Night Pad", imageName: "pads", price: 20000, stock: 5)
            ]
        ),
        VendingMachine(
            name: "AEON BSD",
            subtitle: "AEON Mall BSD City",
            distance: "300m away",
            duration: "8 mins",
            isAvailable: true,
            coordinate: CLLocationCoordinate2D(latitude: -6.3000, longitude: 106.6480),
            products: [
                VendingMachineProduct(name: "Regular Pad", imageName: "pads", price: 15000, stock: 10),
                VendingMachineProduct(name: "Wings Pad", imageName: "pads", price: 18000, stock: 6),
                VendingMachineProduct(name: "Pantyliner", imageName: "pads", price: 12000, stock: 0),
                VendingMachineProduct(name: "Night Pad", imageName: "pads", price: 20000, stock: 4)
            ]
        ),
        VendingMachine(
            name: "Summarecon Mall",
            subtitle: "Summarecon Mall Serpong",
            distance: "800m away",
            duration: "15 mins",
            isAvailable: false,
            coordinate: CLLocationCoordinate2D(latitude: -6.3045, longitude: 106.6435),
            products: [
                VendingMachineProduct(name: "Regular Pad", imageName: "pads", price: 15000, stock: 0),
                VendingMachineProduct(name: "Wings Pad", imageName: "pads", price: 18000, stock: 0),
                VendingMachineProduct(name: "Pantyliner", imageName: "pads", price: 12000, stock: 0),
                VendingMachineProduct(name: "Night Pad", imageName: "pads", price: 20000, stock: 0)
            ]
        )
    ]
    
    var selectedVendingMachine: VendingMachine? = nil
    var selectedProduct: VendingMachineProduct? = nil
    var selectedQuantity: Int = 1
    
    var isShowingDetailsSheet: Bool = false
    var isShowingProductsListHome: Bool = false
    var isShowingProductsListMap: Bool = false
    var shouldNavigateToProductsList: Bool = false
    
    init() {
        self.selectedVendingMachine = vendingMachines.first

        bookings = [
            Booking(
                vendingMachine: vendingMachines[0],
                date: Date(),
                totalPrice: 3000,
                status: .readyForPickup
            ),

            Booking(
                vendingMachine: vendingMachines[0],
                date: Date(),
                totalPrice: 3000,
                status: .collected
            ),

            Booking(
                vendingMachine: vendingMachines[1],
                date: Date(),
                totalPrice: 3000,
                status: .paymentFailed
            )
        ]
    }
}
