//
//  EditContactInfoViewController.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 06/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class EditContactInfoViewController:UIViewController{
	var contact: contactsModel?
	let net = network()
	
	@IBOutlet weak var imageView: UIImageView!
	
	@IBOutlet weak var ageGroup: UITextField!
	@IBOutlet weak var name: UITextField!
	@IBOutlet weak var gender: UITextField!
	@IBOutlet weak var phoneNumber: UITextField!
	
	@IBAction func backPressed(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}
	@IBAction func donePressed(_ sender: Any) {
	
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
		guard let phoneNumber = self.phoneNumber.text else{
			return
		}
		//print(contact?.contactsId!)
		
		if let id = contact?.contactsId {
			net.updateContact(["name":name, "sex":gender, "age_group":ageGroup, "phoneNumber":phoneNumber, "contactId":id ])
		}
	}
	
	override func  viewDidLoad(){
		super.viewDidLoad()
		imageView.roundCorners()
		
		let notificationNme = NSNotification.Name("contactUpdated")
		NotificationCenter.default.addObserver(self, selector: #selector(self.dismissController), name: notificationNme, object: nil)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		fetchInitialDetails()
	}
	func fetchInitialDetails(){
		
		self.name.text = contact?.name
		self.gender.text = contact?.sex
		self.ageGroup.text  = contact?.dob
		self.phoneNumber.text = contact?.phoneNumber
	}
	func dismissController(){
		hero_dismissViewController()
	}
}
