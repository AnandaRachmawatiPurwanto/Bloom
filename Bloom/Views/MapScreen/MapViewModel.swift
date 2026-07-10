//
//  MapViewModel.swift
//  Bloom
//

import SwiftUI
import MapKit
import Combine

class MapViewModel: ObservableObject {
    @Published var route: MKRoute? = nil
    @Published var cameraPosition: MapCameraPosition = .userLocation(followsHeading: true, fallback: .automatic)
    @Published var vendingMachines: [VendingMachine] = []
    
    private var appState: AppState?
    private var cancellables = Set<AnyCancellable>()
    
    func setup(appState: AppState) {
        self.appState = appState
        
        // Sync vending machines
        appState.$vendingMachines
            .sink { [weak self] machines in
                self?.vendingMachines = machines
            }
            .store(in: &cancellables)
            
        // Sync route changes
        appState.$routeDestination
            .sink { [weak self] destination in
                self?.handleDestinationChange(destination)
            }
            .store(in: &cancellables)
            
        // Sync user location changes
        appState.locationManager.$userLocation
            .sink { [weak self] location in
                self?.handleLocationChange(location)
            }
            .store(in: &cancellables)
    }
    
    func resetCameraToUserLocation() {
        withAnimation {
            cameraPosition = .userLocation(fallback: .automatic)
        }
    }
    
    private func handleDestinationChange(_ destination: CLLocationCoordinate2D?) {
        guard let destination = destination,
              let userLocation = appState?.locationManager.userLocation else {
            self.route = nil
            return
        }
        calculateRoute(from: userLocation, to: destination)
    }
    
    private func handleLocationChange(_ location: CLLocationCoordinate2D?) {
        guard let location = location,
              let destination = appState?.routeDestination else { return }
        calculateRoute(from: location, to: destination)
    }
    
    func calculateRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: source))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
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
