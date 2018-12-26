//
//  PickLocationOnMapModels.swift
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

struct GetRestaurantsListRequestModel {
	var lat: String?
	var long: String?
}

struct GetRestaurantsListResponseModelList: Codable {
	var restaurantsList: [GetRestaurantsListResponseModel]?
}

struct GetRestaurantsListResponseModel: Codable {
	var id: Int?
	var name: String?
	var description: String?
	var delivery_fee: String?
	var cover_img_url: String?
	var asap_time: String?
}
