import SwiftUI
import MapKit

struct BloomMap: View {

    @EnvironmentObject var appState: AppState

    @StateObject private var locationManager = LocationManager()

    @State private var route: MKRoute?

    @State private var cameraPosition: MapCameraPosition =
        .userLocation(
            followsHeading: true,
            fallback: .automatic
        )

    var body: some View {

        Map(position: $cameraPosition) {

            // Titik lokasi user
            UserAnnotation()

            // Marker tujuan
            Marker(
                "Bloom Central",
                image: "Pads",
                coordinate: .bloomCentral
            )
            .tint(.pink)

            Marker(
                "Bloom Station",
                image: "Pads",
                coordinate: .bloomStation
            )
            .tint(.gray)

            Marker(
                "Bloom Plaza",
                image: "Pads",
                coordinate: .bloomPlaza
            )
            .tint(.pink)

            if let route {
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

            cameraPosition = .userLocation(
                followsHeading: true,
                fallback: .automatic
            )

            if let destination = appState.routeDestination,
               let userLocation = locationManager.userLocation {

                calculateRoute(
                    from: userLocation,
                    to: destination
                )
            }

        }
        .onChange(of: locationManager.userLocation) { location in

            guard
                let location,
                let destination = appState.routeDestination
            else { return }

            calculateRoute(
                from: location,
                to: destination
            )
        }
        .onChange(of: appState.routeDestination) { destination in

            guard
                let destination,
                let userLocation = locationManager.userLocation
            else {
                route = nil
                return
            }

            calculateRoute(
                from: userLocation,
                to: destination
            )
        }
    }

    private func calculateRoute(
        from source: CLLocationCoordinate2D,
        to destination: CLLocationCoordinate2D
    ) {

        let request = MKDirections.Request()

        request.source =
            MKMapItem(
                placemark:
                    MKPlacemark(coordinate: source)
            )

        request.destination =
            MKMapItem(
                placemark:
                    MKPlacemark(coordinate: destination)
            )

        request.transportType = .walking

        Task {

            do {

                let response =
                    try await MKDirections(
                        request: request
                    ).calculate()

                if let route = response.routes.first {

                    await MainActor.run {

                        withAnimation {

                            self.route = route

                            cameraPosition =
                                .rect(route.polyline.boundingMapRect)

                        }

                    }

                }

            } catch {

                print(error.localizedDescription)

            }

        }
    }

}
// Ekstensi untuk menyimpan titik lokasi secara rapi dan menambahkan Equatable conformance
extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    
    static let bloomCentral = CLLocationCoordinate2D(latitude: -6.3024, longitude: 106.6522)
    static let bloomStation = CLLocationCoordinate2D(latitude: -6.3000, longitude: 106.6480)
    static let bloomPlaza   = CLLocationCoordinate2D(latitude: -6.3045, longitude: 106.6435)
}

