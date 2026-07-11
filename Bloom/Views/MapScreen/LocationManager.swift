//
//  LocationManager.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 02/07/26.
//
import Foundation
import CoreLocation
import Observation

@Observable class LocationManager: NSObject {

    private let manager = CLLocationManager()

    var userLocation: CLLocationCoordinate2D?
    var heading: CLHeading?

    override init() {
        super.init()

        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.headingFilter = kCLHeadingFilterNone

        manager.requestWhenInUseAuthorization()

        if CLLocationManager.headingAvailable() {
            manager.startUpdatingHeading()
        }

        manager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {

        guard let location = locations.last else { return }

        DispatchQueue.main.async {
            self.userLocation = location.coordinate
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateHeading newHeading: CLHeading
    ) {

        DispatchQueue.main.async {
            self.heading = newHeading
        }
    }

    func locationManagerShouldDisplayHeadingCalibration(
        _ manager: CLLocationManager
    ) -> Bool {
        true
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print(error.localizedDescription)
    }
}
