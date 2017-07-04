//
//  AddNewContactViewController.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 05/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class AddNewContactController: UIViewController{
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var cancel: UIBarButtonItem!
	@IBAction func cancelPressed(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		imageView.roundCorners()
		
	}
}
