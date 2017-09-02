//
//  contact.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 29/08/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class pincode{
	let pincodeString:String = "http://52.91.31.125:3000/pincode"
	let state:String = "http://52.91.31.125:3000/state"
	let cityString:String = "http://52.91.31.125:3000/city"
	
	func pincode(_ pin:String){
		let parameter : Parameters = ["pincode":pin]
		
	}
	
	
}
