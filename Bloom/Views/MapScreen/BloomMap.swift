import SwiftUI
import MapKit

struct BloomMap: View {
    @ObservedObject var viewModel: MapViewModel

    var body: some View {
        Map(position: $viewModel.cameraPosition) {
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

