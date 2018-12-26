//
//  NetworkService.swift
//  DoorDashDemo
//
//  Created by Saikumar Kankipati on 12/26/18.
//  Copyright © 2018 Saikumar Kankipati. All rights reserved.
//

import Foundation

final class NetworkManager {
	
	private static var sharedInstanceInterface: SharedInstanceInterface?
	
	private init() {
		
	}
	
	static func shared() -> SharedInstanceInterface {
		var result: SharedInstanceInterface? = nil
		
		NetworkManager.sharedInstanceInterface = MessagingAws()
		
		return result!
	}
}
