//
//  AppState.swift
//  Bloom
//

import SwiftUI
import MapKit
import Combine

class AppState: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var routeDestination: CLLocationCoordinate2D? = nil
    @Published var routeDestinationName: String = ""
}
