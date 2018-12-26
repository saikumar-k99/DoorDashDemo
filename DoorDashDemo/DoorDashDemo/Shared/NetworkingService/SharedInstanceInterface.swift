//
//  RestAPICallsList.swift
//  DoorDashDemo
//
//  Created by Saikumar Kankipati on 12/26/18.
//  Copyright © 2018 Saikumar Kankipati. All rights reserved.
//

import Foundation

protocol SharedInstanceInterface {
	
	typealias RestAPISuccessCompletionBlock = (_ json: Any?) -> Void
	typealias RestAPIErrorCompletionBlock = (_ error: Error?) -> Void
	typealias RestAPIAdditionalHeaderValue = (headerField: String, headerValue: String)
	
	func getRestaurantsListForLocation(requestModel: GetRestaurantsListRequestModel ,successCompletion: @escaping RestAPICallerService.RestAPISuccessCompletionBlock, errorCompletion: @escaping RestAPICallerService.RestAPIErrorCompletionBlock, responseModel: GetRestaurantsListResponseModelList)
}
