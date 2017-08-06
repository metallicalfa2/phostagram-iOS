//
//  UIViewControlller.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 13/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

extension UIViewController{
	func hideKeyboard()
	{
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(
			target: self,
			action: #selector(UIViewController.dismissKeyboard))
		
		view.addGestureRecognizer(tap)
	}
	
	func dismissKeyboard()
	{
		view.endEditing(true)
	}
	
	func dismissViewController(){
		navigationController?.popViewController(animated: true)
	}
}
