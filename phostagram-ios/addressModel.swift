//
//  addressModel.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 12/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

struct addressModel{

	static let contactAddresses : [addressModel] = []
	
	var addressLineOne: String?
	var pincode: Int
	var state : String
	var city : String
	var userAddressId: String
	
	init(_ line1:String, pincode:Int, state:String, city:String, userAddressId:String) {
		self.addressLineOne = line1
		self.pincode = pincode
		self.state = state
		self.city = city
		self.userAddressId = userAddressId
	}
}
