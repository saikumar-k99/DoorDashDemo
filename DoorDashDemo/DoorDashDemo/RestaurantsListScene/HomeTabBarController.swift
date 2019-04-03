//
//  HomeTabBarController.swift
//  DoorDashDemo
//
//  Created by Saikumar Kankipati on 12/26/18.
//  Copyright © 2018 Saikumar Kankipati. All rights reserved.
//

import UIKit

class HomeTabBarController: UITabBarController {

	static func getInstance() -> HomeTabBarController {
		let storyBoard = UIStoryboard(name: "RestaurantsList", bundle: nil)
		let vc = storyBoard.instantiateViewController(withIdentifier: "HomeTabBarController") as! HomeTabBarController
		
		return vc
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)

		setTabBarItemImages()
	  setTabItemsTextColors()
		
		self.navigationController?.setNavigationBarHidden(true, animated: false)
	}
	
	func setTabBarItemImages() {
		self.tabBar.items?[0].image = UIImage(named: "tab-explore")
		self.tabBar.items?[0].selectedImage = UIImage(named: "tab-explore")?.withRenderingMode(.alwaysOriginal)
		
		self.tabBar.items?[1].image = UIImage(named: "star-white")
		self.tabBar.items?[1].selectedImage = UIImage(named: "tab-star")
	}
	
	func setTabItemsTextColors() {
		let unselectedItem: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.gray]
		let selectedItem: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.red]
		
		self.tabBar.items?[0].setTitleTextAttributes(unselectedItem as? [NSAttributedString.Key : Any], for: .normal)
		self.tabBar.items?[0].setTitleTextAttributes(selectedItem as? [NSAttributedString.Key : Any], for: .highlighted)
		
		self.tabBar.items?[1].setTitleTextAttributes(unselectedItem as? [NSAttributedString.Key : Any], for: .normal)
		self.tabBar.items?[1].setTitleTextAttributes(selectedItem as? [NSAttributedString.Key : Any], for: .highlighted)
	}
}

extension HomeTabBarController {
	
	func getViewController(id: String) -> UIViewController? {
		
		guard let navController = self.viewControllers?.first as? UINavigationController else {
			return nil
		}
		
		let targetVC = navController.viewControllers.filter { vc in
			vc.restorationIdentifier == id
		}
		
		guard let vc = targetVC.first as? RestarantsListViewController else { return nil}
		
		return vc
	}
}
