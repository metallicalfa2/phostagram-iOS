//
//  order.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 07/08/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
import Alamofire

class orders{

	static var addressIds : [String] = []
	static var userAddressIds : [String] = []
	static var contactIds : [String] = []
	
	let orderDraftString = "http://13.126.4.227:3000/orders/draft/new"
	let orderDraftAddPhoto = "http://13.126.4.227:3000//orders/draft/addPhoto"
	
	func newOrderDraft(){
		Alamofire.request(orderDraftString as String, method: .post, parameters: self.loginParameters,encoding: URLEncoding.default).responseJSON { response in
			//print("Request: \(String(describing: response.request))")   // original url reqest
			//print("Response: \(String(describing: response.response))") // http url response
			print("Result in new draft: \(response.result)")                         // response serialization result
			
			if let json = response.result.value {
				//print("JSON: \(json)") // serialized json response
				let res = JSON(json)
				print(res.order)
			}
			
		}
	}
	
	func orderAddPhoto(){
		Alamofire.request(orderDraftAddPhoto as String, method: .post, parameters: self.loginParameters,encoding: URLEncoding.default).responseJSON { response in
			//print("Request: \(String(describing: response.request))")   // original url reqest
			//print("Response: \(String(describing: response.response))") // http url response
			print("Result in new draft: \(response.result)")                         // response serialization result
			
			if let json = response.result.value {
				//print("JSON: \(json)") // serialized json response
				let res = JSON(json)
				print(res.order)
			}
			
		}
	}
}
