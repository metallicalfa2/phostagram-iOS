//
//  AddressViewController.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 28/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController{
	@IBOutlet weak var lineOne: UITextField!
	@IBOutlet weak var state: UITextField!
	@IBOutlet weak var pincode: UITextField!
	@IBOutlet weak var city: UITextField!
	@IBOutlet weak var imageView: UIImageView!
	
	let net = network()
	var contactId : String?
	var contact: contactsModel?
	var addressIndex: Int?
	
	@IBAction func cancelPressed(_ sender: Any) {
	}
	
	@IBAction func donePressed(_ sender: Any) {
		print("done pressed on addnewAddress \n")
		//print(contact?.contactsId)
		
		guard let lineOne = self.lineOne.text else{
			print("enter name")
			return
		}
		guard let state = self.state.text else{
			return
		}
		guard let city = self.city.text else{
			return
		}
		guard let pincode = self.pincode.text else{
			return
		}
		if(contact != nil){
			net.addAddress(["contactId":contact?.contactsId!,"address":["address_line":lineOne, "state":state, "city":city, "pincode":pincode]])
		}else{
			net.updateAddress(["contactId":contact?.contactsId!,"contactAddressId":contact?.addresses?[addressIndex!].userAddressId,"address":["address_line":lineOne, "state":state, "city":city, "pincode":pincode]])
		}
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		imageView.roundCorners()
		loadInitialData()
		let notificationNme = NSNotification.Name("newAddressAdded")
		NotificationCenter.default.addObserver(self, selector: #selector(self.dismissController), name: notificationNme, object: nil)
	}
	
	func loadInitialData(){
		if(contact != nil){
			lineOne.text = contact?.addresses?[addressIndex!].addressLineOne
			state.text = contact?.addresses?[addressIndex!].state
			city.text = contact?.addresses?[addressIndex!].city
			if let pin = contact?.addresses?[addressIndex!].pincode{
				print(pin)
				pincode.text = String(pin)
			}
			
		}
	}
	
	
	func dismissController(){
		hero_dismissViewController()
	}
}
