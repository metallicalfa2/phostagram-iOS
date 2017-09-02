//
//  homeModel.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 27/08/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class homeModel{
	static var orders : [homeModel] = []

	var orderId:String?
	var photoURL:String?
	var time:String?
	var caption:String?
	var place:String?
	var ocassion:String?
	var addresses: [addressModel]?
	
	init(_ orderId:String, photourl:String, time:String, caption:String, place:String, ocassion:String, addresses: [addressModel]){
		self.orderId = orderId
		self.photoURL = photourl
		self.time = time
		self.caption = caption
		self.place = place
		self.ocassion = ocassion
		self.addresses = addresses
	}
}
