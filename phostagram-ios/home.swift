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
	
//	static var addressIds : [String] = []
//	static var userAddressIds : [String] = []
//	static var contactIds : [String] = []
	
	let homepageOrders = "http://52.91.31.125:3000/history/orders/"+"20/0"
	
	func homePageCards(){
		Alamofire.request(homepageOrders as String, method: .post,encoding: URLEncoding.default).responseJSON { response in
			print("Request: \(String(describing: response.request))")   // original url reqest
			print("Response: \(String(describing: response.response))") // h	ttp url response
			print("Result in history/orders: \(response.result)")   // response serialization result
			
			if let json = response.result.value {
				let res = JSON(json)
				//print(res)
				var orders = res["orders"].map{return $1}
				
				orders.forEach{ el in
					var addresses : [addressModel] = []
					for (_,value) in el["userAddresses"]{					addresses.append(addressModel(value["address_line"].string! ,pincode:Int(value["pincode"].string!)!,state:value["state"].string! ,city: value["city"].string!, userAddressId: value["userAddressId"].string!))
					}
					
					let home = homeModel(el["orderid"].stringValue, photourl: el["photos"][0]["photoUrl"].stringValue, time: el["photos"][0]["time"].stringValue, caption: el["photos"][0]["caption"].stringValue, place: el["photos"][0]["place"].stringValue, ocassion: el["photos"][0]["ocassion"].stringValue, addresses: addresses)
					homeModel.orders.append(home)
					print(el["photos"][0]["photoUrl"].stringValue)
				}
				//print(homeModel.orders)
				
				let notificationNme = NSNotification.Name("reloadHomepage")
				NotificationCenter.default.post(name: notificationNme, object: nil)
			}
		}
		
	}
	
}
