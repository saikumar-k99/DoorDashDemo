//
//  PickLocationOnMapWorker.swift
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

class PickLocationOnMapWorker {
	
	func getRestaurantsList(requestModel: GetRestaurantsListRequestModel, responseModel: GetRestaurantsListResponseModelList, closure: @escaping (Any?) -> Void) {
		
		let successCompletion = { (_ json: Any?) -> Void in
			if let restaurantsList = json as? GetRestaurantsListResponseModelList {
					closure(restaurantsList)
			} else {
				closure(NSError(domain: "", code: 999, userInfo: nil))
			}
		}
		
		let errorCompletion = { (error: Error?) -> Void in
			closure(error)
		}
		
		NetworkManager.shared().getRestaurantsListForLocation(requestModel: requestModel, successCompletion: successCompletion, errorCompletion: errorCompletion, responseModel: responseModel)
	}
}
