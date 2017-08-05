//
//  AddressViewCell.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 06/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
class AddressViewCell:UITableViewCell{
	
	var addressId:String?
	@IBOutlet weak var radioImage: UIImageView!
	@IBOutlet weak var delete: UIButton!
	@IBOutlet weak var edit: UIButton!
	@IBOutlet weak var phoneNumber: UILabel!
	@IBOutlet weak var address: UILabel!
	
	@IBAction func editButtonClicked(_ sender: Any) {
	}
	@IBAction func deletePressed(_ sender: Any) {
	}
}
