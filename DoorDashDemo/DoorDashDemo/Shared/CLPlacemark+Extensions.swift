//
//  CLPlacemark+Extensions.swift
//  DoorDashDemo
//
//  Created by Saikumar Kankipati on 12/26/18.
//  Copyright © 2018 Saikumar Kankipati. All rights reserved.
//

import Foundation
import CoreLocation

extension CLPlacemark {
	var readableAddress: String {
		return (self.name ?? "Lake") + (", ") + (self.thoroughfare ?? "wood creek rd")
	}
}
