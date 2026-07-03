import SwiftUI
import MapKit

struct BloomMap: View {
    // 1. Memanggil mesin pemantau lokasi agar izin lokasi aktif
    @StateObject private var locationManager = LocationManager()

    // Posisi kamera awal
    @State private var cameraPosition: MapCameraPosition = .region(.init(
        center: .bloomCentral,
        latitudinalMeters: 1500,
        longitudinalMeters: 1500
    ))
    
    var body: some View {
        // ZStack diberi alignment agar tombol otomatis ke kanan bawah
        ZStack(alignment: .bottomTrailing) {
            
            // Perhatikan: Gunakan position: $cameraPosition agar tombol bisa menggeser peta
            Map(position: $cameraPosition) {
                        
                // 2. Ini adalah baris ajaib untuk memunculkan titik biru lokasi kamu
                UserAnnotation()
                        
                // Marker 1: Custom Image (Pink)
                Marker("Bloom Central", image: "Pads", coordinate: .bloomCentral)
                    .tint(.pink)
                        
                // Marker 2: Unavailable (Gray)
                Marker("Bloom Station", image: "Pads", coordinate: .bloomStation)
                    .tint(.gray)
                        
                // Marker 3: Available (Pink)
                Marker("Bloom Plaza", image: "Pads", coordinate: .bloomPlaza)
                    .tint(.pink)
                        
            }
        }
    }
}

#Preview {
    BloomMap()
}

// Ekstensi untuk menyimpan titik lokasi secara rapi
extension CLLocationCoordinate2D {
    static let bloomCentral = CLLocationCoordinate2D(latitude: -6.3024, longitude: 106.6522)
    static let bloomStation = CLLocationCoordinate2D(latitude: -6.3000, longitude: 106.6480)
    static let bloomPlaza   = CLLocationCoordinate2D(latitude: -6.3045, longitude: 106.6435)
}
