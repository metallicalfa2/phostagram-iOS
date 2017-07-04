//
//  gradientView.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 04/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
@IBDesignable

class gradientView:UIView{

	override class var layerClass: AnyClass{
		get{
			return CAGradientLayer.self
		}
	}

	@IBInspectable var firstColor: UIColor = UIColor.clear {
		didSet{
			updateView()
		}
	}
	@IBInspectable var secondColor: UIColor = UIColor.clear {
		didSet{
			updateView()
		}
	}

	func updateView(){
		let layer = self.layer as! CAGradientLayer
		layer.colors = [firstColor.cgColor , secondColor.cgColor]
	}
}
