//
//  EditContactInfoViewController.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 06/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class EditContactInfoViewController:UIViewController{
	
	@IBOutlet weak var imageView: UIImageView!
	@IBAction func backPressed(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}
	@IBAction func donePressed(_ sender: Any) {
		self.dismiss(animated:true,completion: nil)
	}
	
	override func  viewDidLoad(){
		super.viewDidLoad()
		imageView.roundCorners()
	}
}
