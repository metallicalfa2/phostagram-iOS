//
//  profileModel.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 11/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class profileModel{

	static let sharedInstance = profileModel()

	var name: String?
	var noOfPhostcards: String?
	var phoneNumber: String?
	var sex: String?
	var interests : [String]?
	var profilePic : String?
	var dob : String?
	var email : String?
	var userId: String?
	var addresses: [addressModel]?
	
	func setValues(_ name: String, noOfPhostcards: String?,phoneNumber:String, sex:String, interests: [String]? , profilePic:String?, dob:String, email:String, userId:String , addresses:[addressModel]? ) {
		self.name = name
		self.noOfPhostcards = noOfPhostcards
		self.phoneNumber = phoneNumber
		self.sex = sex
		self.interests = interests
		self.profilePic = profilePic
		self.dob = dob
		self.email = email
		self.userId = userId
		self.addresses = addresses
	}
	
	private init(){
		print("profileModel initialised")
	}
}
