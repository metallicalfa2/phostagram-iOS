//
//  AddNewContactViewController.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 05/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class AddNewContactController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
	let picker = UIImagePickerController()
	let net = network()
	
	@IBOutlet weak var name: UITextField!
	@IBOutlet weak var gender: UITextField!
	@IBOutlet weak var ageGroup: UITextField!
	@IBOutlet weak var phone: UITextField!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var address: UITextField!
	@IBOutlet weak var pincode: UITextField!
	@IBOutlet weak var state: UITextField!
	@IBOutlet weak var city: UITextField!
	
	@IBAction func cancelPressed(_ sender: Any) {
	//	self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func donePressed(_ sender: Any) {
		//print(self.name.text)
		
		guard let name = self.name.text else{
			print("enter name")
			return
		}
		guard let gender = self.gender.text else{
			return
		}
		guard let ageGroup = self.ageGroup.text else{
			return
		}
		guard let phone = self.phone.text else{
			return
		}
		guard let address = self.address.text else{
			return
		}
		guard let pincode = self.pincode.text else{
			return
		}
		guard let state = self.state.text else{
			return
		}
		guard let city = self.city.text else{
			return
		}
		
		net.newContact(["name":name, "sex":gender, "age_group":ageGroup, "phoneNumber":phone, "addresses":[["address_line":address,"state":state,"city":city,"pincode":pincode]] ])
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.navigationBar.isHidden = true
		imageView.roundCorners()
		//picker.delegate = self
		self.hideKeyboard()
		
		self.name.delegate = self
		self.gender.delegate = self
		self.ageGroup.delegate = self
		self.phone.delegate = self
		self.address.delegate = self
		self.pincode.delegate = self
		self.state.delegate = self
		self.city.delegate = self

		let notificationNme = NSNotification.Name("newContactAdded")
		NotificationCenter.default.addObserver(self, selector: #selector(self.dismissController), name: notificationNme, object: nil)
	}
	
	func dismissController(){
		hero_dismissViewController()

	}
	
	
}
