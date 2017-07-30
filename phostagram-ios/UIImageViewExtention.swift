//
//  UIImageViewExtention.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 04/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

extension UIImageView{
	func cornerRadius(radius:CGFloat){
		self.layer.cornerRadius = CGFloat(radius)
		self.layer.masksToBounds = true
	}
	
	
	func roundCorners(){
		let radius = self.frame.width / 2
		self.layer.cornerRadius = radius
		self.layer.masksToBounds = true
	}
	
	public func imageFromServerURL(url: URL) {
		
		URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
			
			if error != nil {
				print(error ?? "error ocurred")
				return
			}
			DispatchQueue.main.async(execute: { () -> Void in
				let image = UIImage(data: data!)
				self.image = image
			})
			
		}).resume()
	}

	func dropShadow(_ scale: Bool = true) {
		self.layer.masksToBounds = false
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowOpacity = 0.18
		self.layer.shadowOffset = CGSize(width: 1, height: 1)
		self.layer.shadowRadius = 2
		self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
		self.layer.shouldRasterize = true
		self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
	}
}
