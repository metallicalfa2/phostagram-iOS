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
	let loginParameters: Parameters = ["phoneNumber": "9111100000", "password": "phostagram"]

	let loginURL:String = "http://13.126.4.227:3000/login"
	let contactsURL:String = "http://13.126.4.227:3000/contacts"
	let contactsAddURL:String = "http://13.126.4.227:3000/contacts/add"
	let contactsUpdateURL:String = "http://13.126.4.227:3000/contacts/update"
	let addAddress:String = "http://13.126.4.227:3000/contacts/address/add"
	let updateAddress:String = "http://13.126.4.227:3000/contacts/address/update"
	let deleteAddressString:String = "http://13.126.4.227:3000/contacts/address/remove"
	let profileURL:String = "http://13.126.4.227:3000/profile"
	let contactsDeleteURL:String = "http://13.126.4.227:3000/contacts/remove"
	
	func login(){

		Alamofire.request(loginURL as String, method: .post, parameters: self.loginParameters,encoding: URLEncoding.default).responseJSON { response in
			//print("Request: \(String(describing: response.request))")   // original url reqest
			//print("Response: \(String(describing: response.response))") // http url response
			print("Result in login: \(response.result)")                         // response serialization result
			
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
			print("Result in Profile: \(response.result.value)")                         // response serialization result
			
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
			print("Result in get Contacts: \(response.result.value)")                         // response serialization result
			
			if let json = response.result.value {
				let contacts = JSON(json)
				self.createSingletonContacts(contacts,withCompletion: self.reloadData)
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
	
	func createSingletonContacts(_ contacts:JSON, withCompletion completion:() -> Void){
		
		let contacts = contacts["contacts"].map{ return $1 }
		contactsModel.userContacts = []
		
		contacts.forEach{
			let contact = contactsModel()
			let addresses = $0["addresses"].map{ return $1 }
			let contactAddresses : [addressModel] = addresses.map{index in
				return (addressModel(index["line1"].string! ,pincode:Int(index["pincode"].string!) ?? 0 ,state:index["state"].string! ,city: index["city"].string!, userAddressId: index["contactAddressId"].string!))
			}
			contact.setValues($0["name"].string!, phoneNumber: $0["phoneNumber"].string!, sex:$0["sex"].string!, dob:$0["age_group"].string! , contactsId:$0["contactId"].string!, addresses: contactAddresses, ageGroup: $0["age_group"].string!)
			contactsModel.userContacts.append(contact)
		}
		completion()		
	}
	
	func reloadData(){
		
		let notificationNme = NSNotification.Name("reloadTableData")
		NotificationCenter.default.post(name: notificationNme, object: nil)
		
		let contactUpdated = NSNotification.Name("contactUpdated")
		NotificationCenter.default.post(name: contactUpdated, object: nil)
		
		let contactDeleted = NSNotification.Name("contactDeleted")
		NotificationCenter.default.post(name: contactDeleted, object: nil)
		
		let newContactAdded = NSNotification.Name("newContactAdded")
		NotificationCenter.default.post(name: newContactAdded, object: nil)
		
		let newAddressAdded = NSNotification.Name("newAddressAdded")
		NotificationCenter.default.post(name: newAddressAdded, object: nil)
	}
	
	
	func newContact(_ array:[String:Any]){
		print("adding new Contact")
		
		Alamofire.request(contactsAddURL as String, method: .post, parameters: array, encoding: URLEncoding.default).responseJSON { response in
			//print("Request: \(String(describing: response.request))")   // original url request
			//print("Response: \(String(describing: response.response))") // http url response
			print("Result in creating a neew contact: \(response.result.value)")                         // response serialization result
			
			if let json = response.result.value {
				let res = JSON(json)
				print(res)
				if( res["status"] != "fail"){
					self.getContacts()

				}
			}
			
		}
	}
	
	func updateContact(_ array:[String:Any]){
		print(array)
		
		Alamofire.request(contactsUpdateURL as String, method: .post, parameters: array, encoding: URLEncoding.default).responseJSON { response in
			//print("Request: \(String(describing: response.request))")   // original url request
			//print("Response: \(String(describing: response.response))") // http url response
			print("Result in update contact: \(response.result.value)")                         // response serialization result
			
			if let json = response.result.value {
				let res = JSON(json)
				print(res)
				if( res["status"] == "success"){
					self.getContacts()

					//let notificationNme = NSNotification.Name("contactUpdated")
					//NotificationCenter.default.post(name: notificationNme, object: nil)
				}
			}
			
		}
	}
	
	
	func deleteContact(_ contactId:String) -> Bool {
		//print(contactId)
		let parameter : Parameters = ["contactId" : contactId]
		
		Alamofire.request(contactsDeleteURL as String, method: .post, parameters: parameter, encoding: URLEncoding.default).responseJSON { response in
			//print("Request: \(String(describing: response.request))")   // original url request
			//print("Response: \(String(describing: response.response))") // http url response
			print("Result in deleting a contact: \(response.result.value)")                         // response serialization result
			let res : JSON
			if let json = response.result.value {
				res = JSON(json)
				self.getContacts()
			}
			
		}
		return true
	}
	
	func addAddress(_ array:[String:Any]){
	
		Alamofire.request(addAddress as String, method: .post, parameters: array, encoding: URLEncoding.default).responseJSON { response in
			//print("Request: \(String(describing: response.request))")   // original url request
			//print("Response: \(String(describing: response.response))") // http url response
			print("Result in adding an address: \(response.result)")                         // response serialization result
			if let json = response.result.value {
				let res = JSON(json)
				print(res)
				if( res["status"] == "success"){
					self.getContacts()
				}
				
			}
			
		}
	}
	
	func updateAddress(_ array:[String:Any]){
	
		Alamofire.request(updateAddress as String, method: .post, parameters: array, encoding: URLEncoding.default).responseJSON { response in
			//print("Request: \(String(describing: response.request))")   // original url request
			//print("Response: \(String(describing: response.response))") // http url response
			print("Result in updating an address: \(response.result)")                         // response serialization result
			if let json = response.result.value {
				let res = JSON(json)
				print(res)
				if( res["status"] == "success"){
					self.getContacts()
				}
				
			}
			
		}
	}
	
	func deleteAddress(_ array:[String:Any]){
		
		Alamofire.request(deleteAddressString as String, method: .post, parameters: array, encoding: URLEncoding.default).responseJSON { response in
			//print("Request: \(String(describing: response.request))")   // original url request
			//print("Response: \(String(describing: response.response))") // http url response
			print("Result in deleting address: \(response.result)")                         // response serialization result
			if let json = response.result.value {
				let res = JSON(json)
				print(res)
				if( res["status"] == "success"){
					self.getContacts()
				}
				
			}
			
		}
	}
	
	
}
