//
//  contactsModel.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 12/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class contactsModel{

	static var userContacts : [contactsModel] = []

	var name: String?
	var phoneNumber: String?
	var sex: String?
	var dob : String?
	var contactsId: String?
	var addresses: [addressModel]?
	
	func setValues(_ name: String,phoneNumber:String, sex:String, dob:String , contactsId:String , addresses:[addressModel]? ) {
		self.name = name
		self.phoneNumber = phoneNumber
		self.sex = sex
		self.dob = dob
		self.contactsId = contactsId
		//self.addresses = addresses
	}
}
