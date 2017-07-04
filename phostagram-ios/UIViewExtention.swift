//
//  UIViewExtention.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 04/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

extension UIView{
	func cornerRadiusView(){
		let radius = 5.0
		self.layer.cornerRadius = CGFloat(radius)
		self.layer.masksToBounds = true
	}
}
