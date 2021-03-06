//
//  RestarantsListInteractor.swift
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

protocol RestarantsListBusinessLogic {
}

protocol RestarantsListDataStore {
}

class RestarantsListInteractor: RestarantsListBusinessLogic, RestarantsListDataStore {
  var presenter: RestarantsListPresentationLogic?
  var worker: RestarantsListWorker?
}
