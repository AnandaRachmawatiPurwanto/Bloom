import SwiftUI
import MapKit

struct BloomMap: View {
    @EnvironmentObject var appState: AppState
    
    // Memanggil mesin pemantau lokasi agar izin lokasi aktif
    @StateObject private var locationManager = LocationManager()
    
    // 1. Simpan data rute di sini
    @State private var route: MKRoute?

    // Posisi kamera awal
    @State private var cameraPosition: MapCameraPosition = .region(.init(
        center: .bloomCentral,
        latitudinalMeters: 1500,
        longitudinalMeters: 1500
    ))
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map(position: $cameraPosition) {
                // Menampilkan titik lokasi biru kamu saat ini
                UserAnnotation()
                        
                // Marker tempat tujuan
                Marker("Bloom Central", image: "Pads", coordinate: .bloomCentral)
                    .tint(.pink)
                        
                Marker("Bloom Station", image: "Pads", coordinate: .bloomStation)
                    .tint(.gray)
                        
                Marker("Bloom Plaza", image: "Pads", coordinate: .bloomPlaza)
                    .tint(.pink)
                
                // 2. Jika rute sudah berhasil dihitung, gambar garis rutenya di peta
                if let route {
                    MapPolyline(route)
                        .stroke(Color.AppTheme.activePink, lineWidth: 5) // Garis pink tebal
                }
            }
            // 3. Pantau perubahan lokasi pengguna (menggunakan 1 argument untuk kompatibilitas SDK)
            .onChange(of: locationManager.userLocation) { userLocation in
                if let userLocation, let destination = appState.routeDestination {
                    // Hitung rute dari lokasi user ke tujuan terpilih
                    calculateRoute(from: userLocation, to: destination)
                }
            }
            // 4. Pantau perubahan destinasi rute
            .onChange(of: appState.routeDestination) { destination in
                if let destination, let userLocation = locationManager.userLocation {
                    calculateRoute(from: userLocation, to: destination)
                } else if destination == nil {
                    withAnimation {
                        self.route = nil
                    }
                }
            }
            // 5. Hitung rute jika layar peta baru dibuka dan tujuan sudah diatur
            .onAppear {
                if let destination = appState.routeDestination, let userLocation = locationManager.userLocation {
                    calculateRoute(from: userLocation, to: destination)
                }
            }
        }
    }
    
    // 6. Fungsi pembantu untuk mengalkulasi rute jalan kaki / berkendara
    private func calculateRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: source))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.transportType = .automobile // Bisa diganti .walking jika ingin rute jalan kaki
        
        Task {
            let directions = MKDirections(request: request)
            do {
                let response = try await directions.calculate()
                // Dapatkan rute pertama hasil kalkulasi
                if let calculatedRoute = response.routes.first {
                    withAnimation(.easeIn) {
                        self.route = calculatedRoute
                        // Fokus kamera ke area rute
                        self.cameraPosition = .rect(calculatedRoute.polyline.boundingMapRect)
                    }
                }
            } catch {
                print("Gagal menghitung rute internal: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    BloomMap()
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

