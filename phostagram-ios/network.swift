//
//  network.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 11/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class network{
	
	let unavailable = "Unavailable"
	let loginParameters: Parameters = ["email": "phostagram@phostagram.com", "password": "phostagram"]

	var loginURL:String = "http://13.126.4.227:3000/login"
	var contactsURL:String = "http://13.126.4.227:3000/contacts"
	var newContactURL:String = "http://13.126.4.227:3000/contacts/add"
	let profileURL:String = "http://13.126.4.227:3000/profile"
	
	func login(){
		Alamofire.request(loginURL as String, method: .post, parameters: self.loginParameters,encoding: URLEncoding.default).responseJSON { response in
			//print("Request: \(String(describing: response.request))")   // original url request
			//print("Response: \(String(describing: response.response))") // http url response
			print("Result: \(response.result)")                         // response serialization result
			
			if let json = response.result.value {
				print("JSON: \(json)") // serialized json response
			}
			self.getProfile()
			self.getContacs()
		}
		
	}
	
	func getProfile(){
		Alamofire.request(profileURL as String, method: .get).responseJSON { response in
			//print("Request: \(String(describing: response.request))")   // original url request
			//print("Response: \(String(describing: response.response))") // http url response
			print("Result: \(response.result.value)")                         // response serialization result
			
			if let json = response.result.value {
				let profileData = JSON(json)
				self.createSingletonProfile(profileData)
			}
			
		}
	}
	
	func getContacs(){
		Alamofire.request(contactsURL as String, method: .post).responseJSON { response in
			//print("Request: \(String(describing: response.request))")   // original url request
			//print("Response: \(String(describing: response.response))") // http url response
			//print("Result: \(response.result.value)")                         // response serialization result
			
			if let json = response.result.value {
				let contacts = JSON(json)
				self.createSingletonContacts(contacts)
			}
			
		}
	}
	
	func createSingletonProfile(_ profile: JSON){
		//print(profile["user"]["userAddresses"])
		
		let interests = profile["user"]["interests"].map{ return $1.string! }

		var addresses : [addressModel] = []
		for (_,value) in profile["user"]["userAddresses"]{
			addresses.append(addressModel(value["line1"].string! ,pincode:Int(value["pincode"].string!)!,state:value["state"].string! ,city: value["city"].string!, userAddressId: value["userAddressId"].string!))
		}
		
		profileModel.sharedInstance.setValues(profile["user"]["name"].string ?? self.unavailable,
		                                      noOfPhostcards: "16",
											  phoneNumber: profile["user"]["phoneNumber"].string ?? self.unavailable,
		                                      sex: profile["user"]["sex"].string ?? self.unavailable,
		                                      interests: interests,
		                                      profilePic: profile["user"]["profilePicPath"].string ?? self.unavailable,
											  dob: profile["user"]["dob"].string ?? self.unavailable,
		                                      email: profile["user"]["email"].string ?? self.unavailable,
											  userId: self.unavailable,
		                                      addresses: addresses)
	}
	
	func createSingletonContacts(_ contacts:JSON){
//		let address = addressModel("sdfsdf", pincode:12313 ,state:"sdfsdf" ,city: "sdfsdf", userAddressId: "sdfsdf")

		let contacts = contacts["contacts"].map{ return $1 }
		//print(contacts[0])
		
		contacts.forEach{
			let contact = contactsModel()
			let addresses = $0["addresses"].map{ return $1 }
			var contactAddress : [addressModel] = addresses.map{index in
			return (addressModel(index["line1"].string! ,pincode:Int(index["pincode"].string!)!,state:index["state"].string! ,city: index["city"].string!, userAddressId: index["contactAddressId"].string!))
			
			}
			
			contact.setValues($0["name"].string!, phoneNumber: $0["name"].string!, sex:$0["name"].string!, dob:$0["name"].string! , contactsId:$0["name"].string!, addresses: contactAddress)
			contactsModel.userContacts.append(contact)
			
		}
		
		print(contactsModel.userContacts[0].name)
		
		
	}
}
