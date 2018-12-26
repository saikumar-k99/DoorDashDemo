//
//  RestAPIMakeCall.swift
//  DoorDashDemo
//
//  Created by Saikumar Kankipati on 12/26/18.
//  Copyright © 2018 Saikumar Kankipati. All rights reserved.
//

import Foundation

class RestAPICallerServiceBase {
	func callSuccessCompletionOnMainThread<T: Codable>(json: T, completion:@escaping SharedInstanceInterface.RestAPISuccessCompletionBlock) {
		DispatchQueue.main.async(execute: {
			completion(json)
		})
	}
	
	func callErrorCompletionOnMainThread(error:Error?, completion:@escaping SharedInstanceInterface.RestAPIErrorCompletionBlock) {
		DispatchQueue.main.async(execute: {
			completion(error)
		})
	}
}

class RestAPICallerService: RestAPICallerServiceBase {
	
	
	func makeAPICall<T: Codable>( apiName: String,
										httpMethod: String?,
										successCompletion: @escaping SharedInstanceInterface.RestAPISuccessCompletionBlock,
										errorCompletion: @escaping SharedInstanceInterface.RestAPIErrorCompletionBlock,
										headerParmas: [RestAPIAdditionalHeaderValue]? = nil,
										responseModel: T) {
		
		let url = URL(string: baseURL + apiName)!
		
		var request = URLRequest(url: url)
		request.httpMethod = httpMethod
		
		if let headers = headerParmas {
			for header in headers {
				request.addValue(header.headerValue, forHTTPHeaderField: header.headerField)
			}
		}
		
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			
			guard let data = data, error == nil else {
				self.callErrorCompletionOnMainThread(error: error, completion: errorCompletion)
				return
			}
			
			do {
				let decoder = JSONDecoder()
				let responseCodableModel = try decoder.decode(Array<T>.self, from: data)
				self.callSuccessCompletionOnMainThread(json: responseCodableModel, completion: successCompletion)
				
			} catch {
				self.callErrorCompletionOnMainThread(error: error, completion: errorCompletion)
			}
		}
		task.resume()
	}
}
