//
//  ContactsViewController.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 04/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
import Hero

class ContactsViewController:UIViewController{
	
	@IBOutlet weak var tableView: UITableView!
	let contacts = contactsModel.userContacts
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha:1)
		self.tableView.separatorStyle = .none
		self.tableView.translatesAutoresizingMaskIntoConstraints = false
	}
	
	override func viewWillAppear(_ animated: Bool) {
		navigationController?.isHeroEnabled = true
	}
	
	@IBAction func addNewContactPressed(_ sender: Any) {
		let next = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newContact") as? AddNewContactController)!
		DispatchQueue.main.async {
			self.present(next, animated: true, completion: nil)
		}
	}
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource,UITableViewDataSourcePrefetching{
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
		return contactsModel.userContacts.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactViewCell
		
		//cell.heroModifiers = [.fade, .translate(x:-100)]
		cell.selectionStyle = .none
		cell.contactsLabel.text = "A"
		cell.name.text = contactsModel.userContacts[indexPath.row].name!
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let next = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "editContact") as? EditContactViewController)!
		//next.contactAge.text = "Asdf"
		DispatchQueue.main.async {
			self.present(next, animated: true, completion: nil)
		}
	}
	
	// This methods will be used for smooth scrolling.
	func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
		print("prefetchRowsAt \(indexPaths)")
	}
	
	func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
		print("cancelPrefetchingForRowsAt \(indexPaths)")
	}
}

extension ContactsViewController: HeroViewControllerDelegate {
//	func heroWillStartAnimatingTo(viewController: UIViewController) {
//		if let _ = viewController as? EditContactViewController {
//			tableView.heroModifiers = [.ignoreSubviewModifiers]
//		}  else {
//			tableView.heroModifiers = [.cascade]
//		}
//	}
//	func heroWillStartAnimatingFrom(viewController: UIViewController) {
//		if let _ = viewController as? EditContactViewController {
//			tableView.heroModifiers = [.ignoreSubviewModifiers]
//		} else {
//			tableView.heroModifiers = [.cascade]
//		}
//		
//	}
}
