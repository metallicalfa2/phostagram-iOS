//
//  textFieldViewController.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 04/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
@IBDesignable

open class textField: UITextField{
	public override init(frame: CGRect) {
		super.init(frame: frame)
		
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	@IBInspectable public var cornerRadius: CGFloat = 1.0 {
		didSet {
			self.layer.cornerRadius = self.cornerRadius
		}
	}
	@IBInspectable public var borderWidth: CGFloat = 1.0 {
		didSet {
			self.layer.borderWidth = self.borderWidth
		}
	}
	@IBInspectable public var borderColor: UIColor = UIColor.clear {
		didSet {
			self.layer.borderColor = self.borderColor.cgColor
		}
	}
}
