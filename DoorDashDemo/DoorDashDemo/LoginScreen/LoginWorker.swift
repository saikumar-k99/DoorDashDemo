//
//  LoginWorker.swift
//  DoorDashDemo
//
//  Created by Saikumar Kankipati on 4/1/19.
//  Copyright © 2019 Saikumar Kankipati. All rights reserved.
//

import Foundation

class LoginWorker {
	
	func login(requestModel: LoginRequestModel, responseModel: LoginResposeModel, closure: @escaping (Any?) -> Void) {
		
		let successCompletion = { (_ json: Any?) -> Void in
			if let restaurantsList = json as? [String : String] {
				closure(restaurantsList)
			} else {
				closure(NSError(domain: "", code: 999, userInfo: nil))
			}
		}
		
		let errorCompletion = { (error: Error?) -> Void in
			closure(error)
		}
		
		NetworkManager.shared().authenticateUser(requestModel: requestModel, successCompletion: successCompletion, errorCompletion: errorCompletion, responseModel: responseModel)
	}
	
	func authenticate(requestModel: authRequest, responseModel: authResponse, closure: @escaping (Any?) -> Void) {
		let successCompletion = { (_ json: Any?) -> Void in
			if let restaurantsList = json as? [String:String] {
				closure(restaurantsList)
			} else {
				closure(NSError(domain: "", code: 999, userInfo: nil))
			}
		}
		
		let errorCompletion = { (error: Error?) -> Void in
			closure(error)
		}
		
		NetworkManager.shared().validateUser(requestModel: requestModel, successCompletion: successCompletion, errorCompletion: errorCompletion, responseModel: responseModel)
	}
}
