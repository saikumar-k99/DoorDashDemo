//
//  LocationManager.swift
//  DoorDashDemo
//
//  Created by Saikumar Kankipati on 12/25/18.
//  Copyright © 2018 Saikumar Kankipati. All rights reserved.
//

import CoreLocation

protocol LocationManagerServiceDelegate: class {
	func fetchLocation(currentLocation: CLLocation)
	func fetchLocationFailed(error: Error)
}

class LocationManagerService: NSObject {
	
	var currentLocation: CLLocation?
	var locationManager: CLLocationManager
	weak var delegate: LocationManagerServiceDelegate?
	var isLocationServicesEnabled: Bool = {
		return CLLocationManager.locationServicesEnabled()
	}()
	
	static let shared = LocationManagerService(manager: CLLocationManager())
	
	private init(manager: CLLocationManager) {
		self.locationManager = manager
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
	}
	
	func requestUserPermissionForLocationUpdates() {
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
	}
	
	func lookUpAddressForLocation(location: CLLocation, completionHandler: @escaping (CLPlacemark?)
		-> Void ) {
			let geocoder = CLGeocoder()
			
			// Look up the location and pass it to the completion handler
			geocoder.reverseGeocodeLocation(location,
																			completionHandler: { (placemarks, error) in
																				if error == nil {
																					let firstLocation = placemarks?[0]
																					completionHandler(firstLocation)
																				}
																				else {
																					// An error occurred during geocoding.
																					completionHandler(nil)
																				}
			})
	}
}

extension LocationManagerService: CLLocationManagerDelegate {
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		
		guard let location = locations.last else {
			return
		}
		currentLocation = location
		
		guard let delegate = self.delegate else {
			return
		}
		
		delegate.fetchLocation(currentLocation: currentLocation ?? defaultLocation)
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		guard let delegate = self.delegate else {
			return
		}
		
		delegate.fetchLocationFailed(error: error)
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		
		switch status {
		case .authorizedWhenInUse, .authorizedAlways:
			locationManager.startUpdatingLocation()
		case .denied:
			locationManager.stopUpdatingLocation()
		default:
			locationManager.stopUpdatingLocation()
		}
	}
}
