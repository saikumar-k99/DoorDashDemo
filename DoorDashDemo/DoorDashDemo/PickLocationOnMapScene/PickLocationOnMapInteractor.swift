//
//  PickLocationOnMapInteractor.swift
//  DoorDashDemo
//
//  Created by Saikumar Kankipati on 12/25/18.
//  Copyright (c) 2018 Saikumar Kankipati. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PickLocationOnMapBusinessLogic {
		func getNearByRestaurantsList(locationModel: GetRestaurantsListRequestModel)
}

protocol PickLocationOnMapDataStore {
}

class PickLocationOnMapInteractor: PickLocationOnMapBusinessLogic, PickLocationOnMapDataStore {
  var presenter: PickLocationOnMapPresentationLogic?
  var worker: PickLocationOnMapWorker?
  
  // MARK: Do something
	func getNearByRestaurantsList(locationModel: GetRestaurantsListRequestModel) {
		worker = PickLocationOnMapWorker()
		let responseModel = GetRestaurantsListResponseModel()
		worker?.getRestaurantsList(requestModel: locationModel, responseModel: responseModel, closure: { (response) in
		
			self.presenter?.present(response: response as Any)
		})
	}
	
}
