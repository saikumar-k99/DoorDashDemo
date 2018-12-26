//
//  PickLocationOnMapRootView.swift
//  DoorDashDemo
//
//  Created by Saikumar Kankipati on 12/25/18.
//  Copyright © 2018 Saikumar Kankipati. All rights reserved.
//

import UIKit
import MapKit

protocol PickLocationMapViewDelegate: class {
	func confirmAddressTapped(selectedLocation: CLLocation)
	func geoCodingFailure()
	func loadLocationFailure()
}

class PickLocationOnMapRootView: UIView {
	
	@IBOutlet var mapView: MKMapView!
	@IBOutlet var confirmAddressButton: UIButton!
	@IBOutlet var selectedAddressLabel: UILabel!
	@IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
	
	weak var mapDelegate: PickLocationMapViewDelegate?
	
	lazy var selectedLocationAnnotation: MKPointAnnotation? = {
		return  MKPointAnnotation()
	}()
	
	var currentLocation: CLLocation? {
		didSet {
			updateMapView()
		}
	}
	
	// will be updated to reflect what the user selects
	lazy var userSelectedLocation: CLLocation? = {
		return currentLocation
	}()
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupView()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	func setupView() {
		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
		let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
		
		view.frame = bounds
		view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
		addSubview(view)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		LocationManagerService.shared.delegate = self
	}
	
	@IBAction func confirmAddressButtonTapped(_ sender: UIButton) {
		sender.isEnabled = false
		guard let selectedAddress = userSelectedLocation else {
			return
		}
		
		mapDelegate?.confirmAddressTapped(selectedLocation: selectedAddress)
	}
	
	@IBAction func handleTapOnMap(_ sender: UITapGestureRecognizer) {
		//discard touches until current location is available
		guard let _ = currentLocation else {
			return
		}
		
		let location = sender.location(in: mapView)
		let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
		
		guard let currentAnnotation = selectedLocationAnnotation else {
			return
		}
		
		currentAnnotation.coordinate = coordinate
		mapView.addAnnotation(currentAnnotation)
		
		userSelectedLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
		showTappedLocationStreetAddress(location: userSelectedLocation ?? currentLocation ?? defaultLocation)
	}
	
	func updateMapView() {
		configureMapView()
		showAnnotation()
		zoomToCurrentLocation()
		showTappedLocationStreetAddress(location: currentLocation ?? defaultLocation)
	}
	
	func configureMapView() {
		mapView.mapType = .standard
		mapView.showsUserLocation = true
		mapView.showsScale = true
		mapView.showsCompass = true
	}
	
	func showAnnotation() {
		selectedLocationAnnotation?.coordinate = currentLocation?.coordinate ?? defaultLocationCoordinates
		mapView.addAnnotation(selectedLocationAnnotation ?? MKPointAnnotation())
	}
	
	func zoomToCurrentLocation() {
		let span = MKCoordinateSpan.init(latitudeDelta: 0.0075, longitudeDelta: 0.0075)
		let region = MKCoordinateRegion.init(center: (currentLocation?.coordinate)!, span: span)
		mapView.setRegion(region, animated: true)
	}
	
	func showTappedLocationStreetAddress(location: CLLocation) {
		//Geocode to get street name from location
		LocationManagerService.shared.lookUpAddressForLocation(location: location) { (placemark) in
			
			if placemark != nil {
				DispatchQueue.main.async {
					self.selectedAddressLabel.text = placemark?.readableAddress
					self.confirmAddressButton.isEnabled = true
					LocationManagerService.shared.locationManager.stopUpdatingLocation()
				}
			} else {
				self.mapDelegate?.geoCodingFailure()
			}
		}
	}
}

extension PickLocationOnMapRootView: LocationManagerServiceDelegate {
	func fetchLocation(currentLocation: CLLocation) {
		self.currentLocation = currentLocation
	}
	
	func fetchLocationFailed(error: Error) {
		mapDelegate?.loadLocationFailure()
	}
}

