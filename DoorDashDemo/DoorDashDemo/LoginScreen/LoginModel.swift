//
//  LoginModel.swift
//  DoorDashDemo
//
//  Created by Saikumar Kankipati on 4/1/19.
//  Copyright © 2019 Saikumar Kankipati. All rights reserved.
//

import Foundation

struct LoginRequestModel {
	var username: String?
	var password: String?
}

struct LoginResposeModel: Codable {
	var token: String?
}

struct authRequest {
	var token: String?
}

struct authResponse: Codable {
	var last_name: String?
}
