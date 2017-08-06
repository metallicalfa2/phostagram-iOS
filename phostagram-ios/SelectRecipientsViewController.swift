//
//  SelectRecipientsViewController.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 04/08/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class SelectRecipientsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var addressesSelectedText: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha:1)
		self.tableView.separatorStyle = .none
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.translatesAutoresizingMaskIntoConstraints = false
		self.tableView.backgroundColor = UIColor.white
		
		let notificationNme = NSNotification.Name("reloadTableData")
		NotificationCenter.default.addObserver(self, selector: #selector(self.reloadTableData), name: notificationNme, object: nil)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.tableView.reloadData()
		self.addressesSelectedText.text = String(network.addressIds.count) + " addresses selected"
		
		if(contactsModel.userContacts.count==0){
			self.tableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
		}
	}
	
	@IBAction func addNewContactPressed(_ sender: Any) {
		let next = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newContact") as? AddNewContactController)!
		DispatchQueue.main.async {
			self.navigationController?.pushViewController(next, animated: true)
		}
	}
	
	func reloadTableData(){
		print("reloading data")
		if(self.tableView != nil){
			DispatchQueue.main.async{
				self.tableView.reloadData()
			}
		}
	}
	
	// MARK: - Navigation
	
	override func prepare( for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "selectContactsToSelectAddresses", let destination = segue.destination as? SelectRecipientsAddressesViewController {
			if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
				destination.contactsIndex = indexPath.row
			}
			
		}
		
		
	}

}



extension SelectRecipientsViewController: UITableViewDataSourcePrefetching{
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
		if( contactsModel.userContacts.count == 0){
			return 0
		}
		else {
			return contactsModel.userContacts.count
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactViewCell
		
		//cell.heroModifiers = [.fade, .translate(x:-100)]
		cell.selectionStyle = .none
		let name = contactsModel.userContacts[indexPath.row].name!
		cell.contactsLabel.text = String(name[name.startIndex]).uppercased()
		cell.name.text = name
		cell.contactId = contactsModel.userContacts[indexPath.row].contactsId
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("didSelectRowAt \(indexPath)")
		//performSegue(withIdentifier: "selectContactsToSelectAddresses", sender:self)
	}
	
	// This methods will be used for smooth scrolling.
	func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
		
	}
	
	func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
		print("cancelPrefetchingForRowsAt \(indexPaths)")
	}
	
	
}
