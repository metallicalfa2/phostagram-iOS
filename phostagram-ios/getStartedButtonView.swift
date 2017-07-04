//
//  getStartedButtonView.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 04/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
@IBDesignable

open class getStartedButton: UIButton {

	public override init(frame: CGRect) {
		super.init(frame: frame)

	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	@IBInspectable public var cornerRadius: CGFloat = 1.0 {
		didSet {
			self.layer.cornerRadius = self.cornerRadius
//			self.layer.masksToBounds = false
//
//			self.layer.shadowColor = UIColor.black.cgColor
//			self.layer.shadowOpacity = 0.18
//			self.layer.shadowOffset = CGSize(width: 0, height: 0)
//			self.layer.shadowRadius = 2
//			self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//			self.layer.shouldRasterize = true
//			self.layer.rasterizationScale = UIScreen.main.scale
		}
	}
	
	@IBInspectable public var shadowOpacity: CGFloat = 0.1{
		didSet{
			self.layer.shadowOpacity = Float(self.shadowOpacity)
		}
	}
	
	
}
