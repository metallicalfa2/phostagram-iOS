//
//  home.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 26/08/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class home{
	
	static var addressIds : [String] = []
	static var userAddressIds : [String] = []
	static var contactIds : [String] = []
	
	let homepageOrders = "http://52.91.31.125:3000/history/orders/"+"20/0"
	
	func homePageCards(){
		Alamofire.request(homepageOrders as String, method: .post,encoding: URLEncoding.default).responseJSON { response in
			print("Request: \(String(describing: response.request))")   // original url reqest
			print("Response: \(String(describing: response.response))") // h	ttp url response
			print("Result in history/orders: \(response.result)")   // response serialization result
			
			if let json = response.result.value {
				//print("JSON: \(json)") // serialized json response
				let res = JSON(json)
				var orders = res["orders"]
				
				orders.forEach{ el in
					var addresses : [addressModel] = []
					for (_,value) in $0["userAddresses"]{
						addresses.append(addressModel(value["address_line"].string! ,pincode:Int(value["pincode"].string!)!,state:value["state"].string! ,city: value["city"].string!, userAddressId: value["userAddressId"].string!))
					}
					
					let home = homeModel(el["orderid"], photourl: el["photos"][0]["photoUrl"], time: el["photos"][0]["time"], caption: el["photos"][0]["caption"], place: el["photos"][0]["place"], ocassion: el["photos"][0]["ocassion"], addresses: addresses)
				}
				
			}
		}
		
	}
	
}
