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
    
    private var lastCalculatedUserLocation: CLLocationCoordinate2D? = nil
    private var lastCalculatedDestination: CLLocationCoordinate2D? = nil
    
    func resetCameraToUserLocation() {
        withAnimation {
            cameraPosition = .userLocation(fallback: .automatic)
        }
    }
    
    func updateRoute(userLocation: CLLocationCoordinate2D?, destination: CLLocationCoordinate2D?) {
        guard let source = userLocation, let dest = destination else {
            self.route = nil
            self.lastCalculatedUserLocation = nil
            self.lastCalculatedDestination = nil
            return
        }
        
        // Check if destination has changed
        var needsUpdate = false
        if let lastDest = lastCalculatedDestination {
            if lastDest.latitude != dest.latitude || lastDest.longitude != dest.longitude {
                needsUpdate = true
            }
        } else {
            needsUpdate = true
        }
        
        // Check if user location has changed significantly (>= 10 meters)
        if !needsUpdate {
            if let lastSource = lastCalculatedUserLocation {
                let currentLoc = CLLocation(latitude: source.latitude, longitude: source.longitude)
                let lastLoc = CLLocation(latitude: lastSource.latitude, longitude: lastSource.longitude)
                let distance = currentLoc.distance(from: lastLoc)
                if distance >= 10 { // 10 meters threshold
                    needsUpdate = true
                }
            } else {
                needsUpdate = true
            }
        }
        
        guard needsUpdate else { return }
        
        self.lastCalculatedUserLocation = source
        self.lastCalculatedDestination = dest
        
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
