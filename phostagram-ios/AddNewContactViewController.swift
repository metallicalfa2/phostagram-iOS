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
		let name = self.name.text
		let gender = self.gender.text
		let ageGroup = self.ageGroup.text
		let phone = self.phone.text
		let address = self.address.text
		let pincode = self.pincode.text
		let state = self.state.text
		let city = self.city.text
		
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		imageView.roundCorners()
		picker.delegate = self
		
	}
	
}
