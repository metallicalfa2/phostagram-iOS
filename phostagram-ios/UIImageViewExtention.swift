//
//  UIImageViewExtention.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 04/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

extension UIImageView{
	func cornerRadius(){
		let radius = 5.0
		self.layer.cornerRadius = CGFloat(radius)
		self.layer.masksToBounds = true
	}
	
	
	func roundCorners(){
		let radius = self.frame.width / 2
		self.layer.cornerRadius = radius
		self.layer.masksToBounds = true
	}
	
}
