//
//  restaurantTableViewCell.swift
//  DoorDashDemo
//
//  Created by Saikumar Kankipati on 12/26/18.
//  Copyright © 2018 Saikumar Kankipati. All rights reserved.
//

import UIKit


class restaurantTableViewCell: UITableViewCell {
	
	@IBOutlet var restaurantImageview: UIImageView!
	@IBOutlet var restaurantNameLabel: UILabel!
	@IBOutlet var restaurantCuisineLabel: UILabel!
	@IBOutlet var restaurantDeliveryFeeLabel: UILabel!
	@IBOutlet var estimatedTimeToDelivery: UILabel!
	
	
	func loadContents(cellModel: GetRestaurantsListResponseModel) {
		restaurantNameLabel.text = cellModel.name
		restaurantCuisineLabel.text = cellModel.description
		
		if let fee = cellModel.delivery_fee, fee != 0 {
			restaurantDeliveryFeeLabel.text = "\(fee) delivery"
		} else if cellModel.delivery_fee == 0 {
			restaurantDeliveryFeeLabel.text = "Free Delivery"
		}
		
		guard let deliveryTime = cellModel.asap_time else {
			return
		}
		estimatedTimeToDelivery.text = "\(deliveryTime) min"
		
	}
}
