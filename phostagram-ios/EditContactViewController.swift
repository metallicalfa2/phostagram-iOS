//
//  EditContactViewController.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 05/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class EditContactViewController:UIViewController{
	
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
	}
	
	
	override func viewDidLoad() {
		self.tableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
		self.tableView.separatorStyle = .none
		self.tableView.translatesAutoresizingMaskIntoConstraints = false
		
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
