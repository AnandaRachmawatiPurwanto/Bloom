//
//  MapViewModel.swift
//  Bloom
//

import SwiftUI
import MapKit
import Observation

@Observable class MapViewModel {
    var route: MKRoute? = nil
    var cameraPosition: MapCameraPosition = .userLocation(followsHeading: true, fallback: .automatic)
    
    var vendingMachines: [VendingMachine] {
        appState.vendingMachines
    }
    
    private let appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    func resetCameraToUserLocation() {
        withAnimation {
            cameraPosition = .userLocation(fallback: .automatic)
        }
    }
    
    func updateRoute(userLocation: CLLocationCoordinate2D?, destination: CLLocationCoordinate2D?) {
        guard let source = userLocation, let dest = destination else {
            self.route = nil
            return
        }
        
        let request = MKDirections.Request()
        let sourceLocation = CLLocation(latitude: source.latitude, longitude: source.longitude)
        let destinationLocation = CLLocation(latitude: dest.latitude, longitude: dest.longitude)
        request.source = MKMapItem(location: sourceLocation, address: nil)
        request.destination = MKMapItem(location: destinationLocation, address: nil)
        request.transportType = .walking
        
        Task {
            do {
                let response = try await MKDirections(request: request).calculate()
                if let route = response.routes.first {
                    await MainActor.run {
                        withAnimation {
                            self.route = route
                            self.cameraPosition = .rect(route.polyline.boundingMapRect)
                        }
                    }
                }
            } catch {
                print("Failed to calculate route: \(error.localizedDescription)")
            }
        }
    }
}
