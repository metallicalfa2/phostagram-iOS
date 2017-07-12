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


}
