//
//  EditContactViewController.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 05/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class EditContactViewController:UIViewController{
	
	var contactsIndex : Int = 0
	let net = network()
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var contactName: UILabel!
	@IBOutlet weak var contactSex: UILabel!
	@IBOutlet weak var contactAge: UILabel!
	@IBOutlet weak var contactInitial: UILabel!
	
	@IBAction func backPressed(_ sender: Any) {
		navigationController?.popToRootViewController(animated: true)
	}
	
	@IBAction func addAddressPressed(_ sender: Any) {
	}
	
	@IBAction func editPressed(_ sender: Any) {
		let next = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "editContactInfo") as? EditContactInfoViewController)!
		DispatchQueue.main.async {
			self.present(next, animated: true, completion: nil)
		}
	}
	
	
	@IBAction func deletePressed(_ sender: Any) {
		let _ = net.deleteContact(contactsModel.userContacts[contactsIndex].contactsId!)
		hero_dismissViewController()
	}
	
	override func viewDidLoad() {
		self.tableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
		self.tableView.separatorStyle = .none
		self.tableView.translatesAutoresizingMaskIntoConstraints = false
	}
	
	override func viewWillAppear(_ animated: Bool) {
		fetchInitialDetails()
	}
	func fetchInitialDetails(){
	
		let name = contactsModel.userContacts[contactsIndex].name!
		self.contactName.text = name
		self.contactSex.text = contactsModel.userContacts[contactsIndex].sex
		self.contactAge.text = contactsModel.userContacts[contactsIndex].dob
		self.contactInitial.text = String(name[name.startIndex])
	}
}
extension EditContactViewController:UITableViewDelegate,UITableViewDataSource{
		func numberOfSections(in tableView: UITableView) -> Int {
			return 1
		}
		
		func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
			return 10
		}
		
		func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
			
			let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressViewCell
			
			cell.selectionStyle = .none
			cell.phoneNumber.text = "+91 9321232312"
			
			return cell
		}

		// This methods will be used for smooth scrolling.
		func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
			print("prefetchRowsAt \(indexPaths)")
		}
		
		
		func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
			print("cancelPrefetchingForRowsAt \(indexPaths)")
		}
	
}
