//
//  SendToYourselfViewController.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 07/08/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class SendToYourselfViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var contactName: UILabel!
	@IBOutlet weak var contactSex: UILabel!
	@IBOutlet weak var contactAge: UILabel!
	@IBOutlet weak var contactInitial: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SendToYourselfViewController:UITableViewDelegate,UITableViewDataSource{
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
		return (profileModel.sharedInstance.addresses?.count)!
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressViewCell
		
		let lineOne = profileModel.sharedInstance.addresses?[indexPath.row].addressLineOne
		let pincode = profileModel.sharedInstance.addresses?[indexPath.row].pincode
		let state = profileModel.sharedInstance.addresses?[indexPath.row].state
		let city = profileModel.sharedInstance.addresses?[indexPath.row].city
		
		cell.selectionStyle = .none
		cell.address.text = lineOne! + " " + city! + " " + state! + " - " + String(pincode!)
		cell.phoneNumber.text = profileModel.sharedInstance.phoneNumber
		cell.edit.addTarget(self, action: #selector(editButtonClicked), for: .touchUpInside)
		cell.delete.addTarget(self, action: #selector(deleteButtonClicked), for: .touchUpInside)
		cell.edit.tag = indexPath.row
		cell.delete.tag = indexPath.row
		cell.addressId = profileModel.sharedInstance.addresses?[indexPath.row].userAddressId
		
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
		//print(cell ?? "cell")
		//print(indexPath)
		if(cell?.radioImage.image == #imageLiteral(resourceName: "radio")){
			cell?.radioImage.image = #imageLiteral(resourceName: "radio-selected")
			order.addressIds.append((cell?.addressId)!)
		}else{
			cell?.radioImage.image = #imageLiteral(resourceName: "radio")
			order.addressIds = order.addressIds.filter{ $0 != (cell?.addressId)! }
		}
		
		print(order.addressIds)
	}
	
	func editButtonClicked(_ sender:AnyObject){
		let button = sender as? UIButton
		//print(button?.tag)
		
		let next = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addAddress") as? AddressViewController)!
		//print(contactsModel.userContacts[contactsIndex].contactsId)
		//next.contactId = contactsModel.userContacts[contactsIndex].contactsId
		//next.contact = contactsModel.userContacts[contactsIndex]
		next.addressIndex = button?.tag
		
		DispatchQueue.main.async {
			self.present(next, animated: true, completion: nil)
		}
	}
	
	func deleteButtonClicked(_ sender:AnyObject){
		let button = sender as? UIButton
		let tag = button?.tag
		//print(tag)
		
		//if let addressId = contactsModel.userContacts[contactsIndex].addresses?[tag!].userAddressId , let tag = button?.tag {
		//	print(addressId)
		//	net.deleteAddress( ["contactId": String(tag) ,"contactAddressId":addressId ] )
		//}
		
	}
	
	
}
