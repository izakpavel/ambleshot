//
//  LocationService.swift
//  AmbleShot
//
//  Created by myf on 01/11/2019.
//  Copyright © 2019 nerdyak. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService : NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var shots: [Shot]
    @Published var running: Bool
   
    private var locationManager : CLLocationManager
    
    override init() {
        self.shots = [Shot(id: 0, lat: 13.123, lng: 17.456), Shot(id: 1, lat: -13.123, lng: 17.456), Shot(id: 2, lat: 13.123, lng: -17.456)] // DEBUG ONLY
        self.running = false
        self.locationManager = CLLocationManager()
        
        super.init()
        
        self.setupLocationManager()
    }
    
    func setupLocationManager(){
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 100
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.delegate = self
    }
    
    func isAllowedToWorkInBackground() -> Bool{
        if CLLocationManager.locationServicesEnabled() {
            let authStatus = CLLocationManager.authorizationStatus()
            return authStatus == .authorizedAlways
        }
        return false
    }
    
    func start() {
        if (running) {
            stop()
        }
        if isAllowedToWorkInBackground() {
            locationManager.startUpdatingLocation()
            running = true
        }
    }
    
    func stop () {
        locationManager.stopUpdatingLocation()
        running = false
    }
    
    /// Location delegate functions
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
}