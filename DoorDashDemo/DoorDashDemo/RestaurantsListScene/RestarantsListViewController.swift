//
//  RestarantsListViewController.swift
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

protocol RestarantsListDisplayLogic: class {
}

class RestarantsListViewController: UIViewController, RestarantsListDisplayLogic {
	
	@IBOutlet var restaurantTableView: UITableView!
	
  var interactor: RestarantsListBusinessLogic?
  var router: (NSObjectProtocol & RestarantsListRoutingLogic & RestarantsListDataPassing)?
	
	var dataSource: [GetRestaurantsListResponseModel]?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController = self
    let interactor = RestarantsListInteractor()
    let presenter = RestarantsListPresenter()
    let router = RestarantsListRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
	
	static func getInstance() -> RestarantsListViewController {
		let storyBoard = UIStoryboard(name: "RestaurantsList", bundle: nil)
		let vc = storyBoard.instantiateViewController(withIdentifier: "RestaurantsList") as! RestarantsListViewController
		
		return vc
	}
	
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		self.title = "DoorDash"
		self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
		
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav-address")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
	}
}

extension RestarantsListViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		guard  let count = dataSource?.count else {
			return 0
		}
		
		return count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let displayModel = dataSource?[indexPath.row] else {
			return UITableViewCell()
		}
		
		let cell = restaurantTableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCellID", for: indexPath) as! restaurantTableViewCell
		
	
		cell.loadContents(cellModel: displayModel)
		
		return cell
	}
	
	
	
}
