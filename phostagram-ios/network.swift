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

protocol contactsDelegate {
	func reloadData()
}

class network:UIViewController{
	
	let contactsController = ContactsViewController()
	
	let unavailable = "Unavailable"
	let loginParameters: Parameters = ["email": "phostagram@phostagram.com", "password": "phostagram"]

	let loginURL:String = "http://13.126.4.227:3000/login"
	let contactsURL:String = "http://13.126.4.227:3000/contacts"
	let newContactURL:String = "http://13.126.4.227:3000/contacts/add"
	let profileURL:String = "http://13.126.4.227:3000/profile"
	let contactsDeleteURL:String = "http://13.126.4.227:3000/contacts/remove"
	
	func login(){
		
		Alamofire.request(loginURL as String, method: .post, parameters: self.loginParameters,encoding: URLEncoding.default).responseJSON { response in
			//print("Request: \(String(describing: response.request))")   // original url request
			//print("Response: \(String(describing: response.response))") // http url response
			print("Result: \(response.result)")                         // response serialization result
			
			if let json = response.result.value {
				print("JSON: \(json)") // serialized json response
			}
			self.getProfile()
			self.getContacts()
		}
		
	}
	
	func getProfile(){
		Alamofire.request(profileURL as String, method: .get).responseJSON { response in
			//print("Request: \(String(describing: response.request))")   // original url request
			//print("Response: \(String(describing: response.response))") // http url response
			//	print("Result: \(response.result.value)")                         // response serialization result
			
			if let json = response.result.value {
				let profileData = JSON(json)
				self.createSingletonProfile(profileData)
			}
			
		}
	}
	
	func getContacts(){
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
		
		let contacts = contacts["contacts"].map{ return $1 }
		contactsModel.userContacts = []
		
		contacts.forEach{
			let contact = contactsModel()
			let addresses = $0["addresses"].map{ return $1 }
			let contactAddresses : [addressModel] = addresses.map{index in
				return (addressModel(index["line1"].string! ,pincode:Int(index["pincode"].string!)!,state:index["state"].string! ,city: index["city"].string!, userAddressId: index["contactAddressId"].string!))
			}
			
			contact.setValues($0["name"].string!, phoneNumber: $0["phoneNumber"].string!, sex:$0["sex"].string!, dob:$0["age_group"].string! , contactsId:$0["contactId"].string!, addresses: contactAddresses)
			contactsModel.userContacts.append(contact)
		}
		print(contactsModel.userContacts.count)
		
		let notificationNme = NSNotification.Name("reloadTableData")
		NotificationCenter.default.post(name: notificationNme, object: nil)
	}
	
	func deleteContact(_ contactId:String) -> Bool {
		print(contactId)
		let parameter : Parameters = ["contactId" : contactId]
		
		Alamofire.request(contactsDeleteURL as String, method: .post, parameters: parameter, encoding: URLEncoding.default).responseJSON { response in
			//print("Request: \(String(describing: response.request))")   // original url request
			//print("Response: \(String(describing: response.response))") // http url response
			//print("Result: \(response.result.value)")                         // response serialization result
			let res : JSON
			if let json = response.result.value {
				res = JSON(json)
				self.getContacts()
			}
			
		}
		return true
		
	}
}
