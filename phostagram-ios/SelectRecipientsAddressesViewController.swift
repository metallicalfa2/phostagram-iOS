//
//  SelectRecipientsAddressesViewController.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 04/08/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class SelectRecipientsAddressesViewController: UIViewController {

	var contactsIndex : Int = 0
	let net = network()
	var contactID:String?
	var currentContactsCount : Int = 0
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var contactName: UILabel!
	@IBOutlet weak var contactSex: UILabel!
	@IBOutlet weak var contactAge: UILabel!
	@IBOutlet weak var contactInitial: UILabel!
	
	@IBAction func backPressed(_ sender: Any) {
		self.dismissViewController()
	}
	
	@IBAction func done(_ sender: Any) {
		dismissViewController()
	}
	@IBAction func editPressed(_ sender: Any) {
		let next = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "editContactInfo") as? EditContactInfoViewController)!
		next.contact = contactsModel.userContacts[contactsIndex]
		DispatchQueue.main.async {
			self.present(next, animated: true, completion: nil)
		}
	}
	
	@IBAction func addNewAddressPressed(_ sender: Any) {
		let next = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addAddress") as? AddressViewController)!
		next.contactId = contactsModel.userContacts[contactsIndex].contactsId
		
		DispatchQueue.main.async {
			//self.present(next, animated: true, completion: nil)
			self.navigationController?.pushViewController(next, animated: true)
		}
		
	}
	
	@IBAction func deletePressed(_ sender: Any) {
		let _ = net.deleteContact(contactsModel.userContacts[contactsIndex].contactsId!)
	}
	
	override func viewDidLoad() {
		self.currentContactsCount = order.contactIds.count
		self.tableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
		self.tableView.separatorStyle = .none
		self.tableView.translatesAutoresizingMaskIntoConstraints = false
		
		let notificationNme = NSNotification.Name("contactUpdated")
		NotificationCenter.default.addObserver(self, selector: #selector(dismissViewController), name: notificationNme, object: nil)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		fetchInitialDetails()
	}
	
	func fetchInitialDetails(){
		print("viewWillAppear now \n")
		let name = contactsModel.userContacts[contactsIndex].name!
		self.contactName.text = name
		self.contactSex.text = contactsModel.userContacts[contactsIndex].sex
		self.contactAge.text = contactsModel.userContacts[contactsIndex].dob
		self.contactInitial.text = String(name[name.startIndex])
		self.contactID = contactsModel.userContacts[contactsIndex].contactsId
		self.reloadTableData()
	}
	
	func reloadTableData(){
		print("reloading data")
		if(self.tableView != nil){
			DispatchQueue.main.async{
				self.tableView.reloadData()
			}
		}
	}
}


extension SelectRecipientsAddressesViewController:UITableViewDelegate,UITableViewDataSource{
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
		return (contactsModel.userContacts[contactsIndex].addresses?.count)!
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressViewCell
		
		let lineOne = contactsModel.userContacts[contactsIndex].addresses?[indexPath.row].addressLineOne
		let pincode = contactsModel.userContacts[contactsIndex].addresses?[indexPath.row].pincode
		let state = contactsModel.userContacts[contactsIndex].addresses?[indexPath.row].state
		let city = contactsModel.userContacts[contactsIndex].addresses?[indexPath.row].city
		
		cell.selectionStyle = .none
		cell.address.text = lineOne! + " " + city! + " " + state! + " - " + String(pincode!)
		cell.phoneNumber.text = contactsModel.userContacts[contactsIndex].phoneNumber
		cell.edit.addTarget(self, action: #selector(editButtonClicked), for: .touchUpInside)
		cell.delete.addTarget(self, action: #selector(deleteButtonClicked), for: .touchUpInside)
		cell.edit.tag = indexPath.row
		cell.delete.tag = indexPath.row
		cell.addressId = contactsModel.userContacts[contactsIndex].addresses?[indexPath.row].userAddressId
		
		return cell
	}
	
	// This methods will be used for smooth scrolling.
	func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
		print("prefetchRowsAt \(indexPaths)")
	}
	
	
	func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
		print("cancelPrefetchingForRowsAt \(indexPaths)")
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cell = tableView.cellForRow(at: indexPath) as? AddressViewCell
		
		if(cell?.radioImage.image == #imageLiteral(resourceName: "radio")){
			cell?.radioImage.image = #imageLiteral(resourceName: "radio-selected")
			order.addressIds.append((cell?.addressId)!)
		}else{
			cell?.radioImage.image = #imageLiteral(resourceName: "radio")
			order.addressIds = order.addressIds.filter{ $0 != (cell?.addressId)! }
		}
		
		if order.contactIds.count == currentContactsCount{
			order.contactIds.append(contactID!)
		}else{
			order.contactIds = order.contactIds.filter { $0 != contactID! }
		}
		
		print(order.addressIds)
	}
	
	func editButtonClicked(_ sender:AnyObject){
		let button = sender as? UIButton
		//print(button?.tag)
		
		let next = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addAddress") as? AddressViewController)!
		//print(contactsModel.userContacts[contactsIndex].contactsId)
		next.contactId = contactsModel.userContacts[contactsIndex].contactsId
		next.contact = contactsModel.userContacts[contactsIndex]
		next.addressIndex = button?.tag
		
		DispatchQueue.main.async {
			self.present(next, animated: true, completion: nil)
		}
	}
	
	func deleteButtonClicked(_ sender:AnyObject){
		let button = sender as? UIButton
		let tag = button?.tag
		//print(tag)
		
		if let addressId = contactsModel.userContacts[contactsIndex].addresses?[tag!].userAddressId , let tag = button?.tag {
			print(addressId)
			net.deleteAddress( ["contactId": String(tag) ,"contactAddressId":addressId ] )
		}
		
	}
	
	
}
