//
//  ContactsViewController.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 04/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
import Hero

class ContactsViewController:UIViewController, UITableViewDelegate, UITableViewDataSource{
	
	@IBOutlet weak var tableView: UITableView!
	var delegate : contactsDelegate?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha:1)
		self.tableView.separatorStyle = .none
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.translatesAutoresizingMaskIntoConstraints = false
		
		let notificationNme = NSNotification.Name("reloadTableData")
		NotificationCenter.default.addObserver(self, selector: #selector(self.reloadTableData), name: notificationNme, object: nil)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		navigationController?.isHeroEnabled = true
		self.tableView.reloadData()
		
		if(contactsModel.userContacts.count==0){
			self.tableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
		}
	}
	
	@IBAction func addNewContactPressed(_ sender: Any) {
		let next = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newContact") as? AddNewContactController)!
		DispatchQueue.main.async {
			self.present(next, animated: true, completion: nil)
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
}

extension ContactsViewController: UITableViewDataSourcePrefetching{
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
		
		cell.heroModifiers = [.fade, .translate(x:-100)]
		cell.selectionStyle = .none
		let name = contactsModel.userContacts[indexPath.row].name!
		cell.contactsLabel.text = String(name[name.startIndex]).uppercased()
		cell.name.text = name
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let next = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "editContact") as? EditContactViewController)!
		
		next.contactsIndex = indexPath.row
		
		DispatchQueue.main.async {
			self.present(next, animated: true, completion: nil)
		}
	}
	
	// This methods will be used for smooth scrolling.
	func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
		
	}
	
	func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
		print("cancelPrefetchingForRowsAt \(indexPaths)")
	}
}

extension ContactsViewController: HeroViewControllerDelegate {
	func heroWillStartAnimatingTo(viewController: UIViewController) {
		if let _ = viewController as? EditContactViewController {
			tableView.heroModifiers = [.ignoreSubviewModifiers]
		}  else {
			tableView.heroModifiers = [.cascade]
		}
	}
	func heroWillStartAnimatingFrom(viewController: UIViewController) {
		if let _ = viewController as? EditContactViewController {
			tableView.heroModifiers = [.ignoreSubviewModifiers]
		} else {
			tableView.heroModifiers = [.cascade]
		}
		
	}
}


extension ContactsViewController: contactsDelegate{
	func reloadData() {
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
}


