//
//  RestAPICallerServiceExtension.swift
//  DoorDashDemo
//
//  Created by Saikumar Kankipati on 12/26/18.
//  Copyright © 2018 Saikumar Kankipati. All rights reserved.
//

import Foundation

extension RestAPICallerService: SharedInstanceInterface {
	
	func getRestaurantsListForLocation(requestModel: GetRestaurantsListRequestModel ,successCompletion: @escaping RestAPICallerService.RestAPISuccessCompletionBlock, errorCompletion: @escaping RestAPICallerService.RestAPIErrorCompletionBlock, responseModel: GetRestaurantsListResponseModel) {
		
		guard let lat = requestModel.lat, let long = requestModel.long else {
			return
		}
		
		let apiName = "v1/store_search/?lat=\(lat)&lng=\(long)"
		
		makeAPICall(apiName: apiName, httpMethod: "GET", successCompletion: successCompletion, errorCompletion: errorCompletion, responseModel: responseModel)
	}
	
	func authenticateUser(requestModel: LoginRequestModel ,successCompletion: @escaping RestAPICallerService.RestAPISuccessCompletionBlock, errorCompletion: @escaping RestAPICallerService.RestAPIErrorCompletionBlock, responseModel: LoginResposeModel) {
		guard let uName = requestModel.username, let pass = requestModel.password else {
			return
		}
		
		let apiName = "v2/auth/token/"
		
		makeAPICall(apiName: apiName, httpMethod: "POST", successCompletion: successCompletion, errorCompletion: errorCompletion, responseModel: responseModel)
		
	}
	
	func validateUser(requestModel: authRequest ,successCompletion: @escaping RestAPICallerService.RestAPISuccessCompletionBlock, errorCompletion: @escaping RestAPICallerService.RestAPIErrorCompletionBlock, responseModel: authResponse) {
		let apiName = "v2/consumer/me/"
		
		makeAPICall(apiName: apiName, httpMethod: "GET", successCompletion: successCompletion, errorCompletion: errorCompletion, responseModel: responseModel)
	}
}
