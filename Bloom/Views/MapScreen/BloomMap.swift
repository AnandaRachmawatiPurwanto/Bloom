import SwiftUI
import MapKit

struct BloomMap: View {
    @Environment(AppState.self) var appState
    @Bindable var viewModel: MapViewModel

    var body: some View {
        @Bindable var bindableAppState = appState
        
        Map(position: $viewModel.cameraPosition, selection: $bindableAppState.selectedVendingMachine) {
            // Titik lokasi user
            UserAnnotation()

            // Marker tujuan
            ForEach(viewModel.vendingMachines) { machine in
                Marker(
                    machine.name,
                    image: "Pads",
                    coordinate: machine.coordinate
                )
                .tint(machine.isAvailable ? .pink : .gray)
                .tag(machine)
            }

            if let route = viewModel.route {
                MapPolyline(route)
                    .stroke(.pink, lineWidth: 5)
            }
        }
        .mapControls {
            MapCompass()
            MapPitchToggle()
            MapUserLocationButton()
            MapScaleView()
        }
        .onAppear {
            viewModel.updateRoute(userLocation: appState.locationManager.userLocation, destination: appState.routeDestination)
        }
        .onChange(of: appState.selectedVendingMachine) { _, newMachine in
            if newMachine != nil && appState.selectedTab == 1 {
                appState.isShowingDetailsSheet = true
            }
        }
        .onChange(of: appState.locationManager.userLocation?.latitude) { _, _ in
            viewModel.updateRoute(userLocation: appState.locationManager.userLocation, destination: appState.routeDestination)
        }
        .onChange(of: appState.locationManager.userLocation?.longitude) { _, _ in
            viewModel.updateRoute(userLocation: appState.locationManager.userLocation, destination: appState.routeDestination)
        }
        .onChange(of: appState.routeDestination?.latitude) { _, _ in
            viewModel.updateRoute(userLocation: appState.locationManager.userLocation, destination: appState.routeDestination)
        }
        .onChange(of: appState.routeDestination?.longitude) { _, _ in
            viewModel.updateRoute(userLocation: appState.locationManager.userLocation, destination: appState.routeDestination)
        }
    }
}
extension CLLocationCoordinate2D {
    static let bloomCentral = CLLocationCoordinate2D(latitude: -6.3024, longitude: 106.6522)
    static let bloomStation = CLLocationCoordinate2D(latitude: -6.3000, longitude: 106.6480)
    static let bloomPlaza   = CLLocationCoordinate2D(latitude: -6.3045, longitude: 106.6435)
}

