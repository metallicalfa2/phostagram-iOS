//
//  order.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 07/08/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class order{

	static var addressIds : [String] = []
	static var userAddressIds : [String] = []
	static var contactIds : [String] = []
	
	let orderDraftString = "http://52.91.31.125:3000/orders/draft/new"
	let orderDraftAddPhoto = "http://52.91.31.125:3000/orders/draft/addPhoto"
	
	func newOrderDraft(){
		Alamofire.request(orderDraftString as String).responseJSON { response in
			print("Request: \(String(describing: response.request))")   // original url reqest
			print("Response: \(String(describing: response.response))") // h	ttp url response
			print("Result in new draft: \(response.result)")   // response serialization result
			
			if let json = response.result.value {
				//print("JSON: \(json)") // serialized json response
				let res = JSON(json)
				print(res["order"])
			}
			
		}
	}
	
	func orderAddPhoto(){
		Alamofire.request(orderDraftAddPhoto as String).responseJSON { response in
			print("Request: \(String(describing: response.request))")   // original url reqest
			print("Response: \(String(describing: response.response))") // http url response
			print("Result in new draft: \(response.result)")	// response serialization result
			
			if let json = response.result.value {
				//print("JSON: \(json)") // serialized json response
				//let res = JSON(json)
				
			}
			
		}
	}
	
	
}
