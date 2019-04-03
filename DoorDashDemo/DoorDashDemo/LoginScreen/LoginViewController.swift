//
//  LoginViewController.swift
//  DoorDashDemo
//
//  Created by Saikumar Kankipati on 4/1/19.
//  Copyright © 2019 Saikumar Kankipati. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet var usernameTextField: UITextField!
	@IBOutlet var passwordTextField: UITextField!
	@IBOutlet var submitButton: UIButton!
	
	 lazy var worker: LoginWorker? = LoginWorker()
	
    override func viewDidLoad() {
        super.viewDidLoad()
				usernameTextField.delegate = self
				passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
	static func getInstance() -> RestarantsListViewController {
		let storyBoard = UIStoryboard(name: "PickLocationOnMap", bundle: nil)
		let vc = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! RestarantsListViewController
		
		return vc
	}
	
	@IBAction func submitTapped(_ sender: UIButton) {
		guard  let uText = usernameTextField.text, let pText = passwordTextField.text else {
			return
		}
		let loginModel = LoginRequestModel(username: uText, password: pText)
		var responseModel = LoginResposeModel(token: "")
		
		worker?.login(requestModel: loginModel, responseModel: responseModel, closure: { (response) in
			print(response)
			let token = response as? String
			let request = authRequest(token: token)
			let res = authResponse(last_name: "")
			
			self.worker?.authenticate(requestModel: request, responseModel: res, closure: { (response) in
				print(response)
			})
		})
	}
}
