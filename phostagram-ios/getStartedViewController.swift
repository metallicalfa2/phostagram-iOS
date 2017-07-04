//
//  getStartedViewController.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 04/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class getStartedViewController: UIViewController, UIScrollViewDelegate{
	
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var pageControl: UIPageControl!
	@IBOutlet weak var getStartedButton: getStartedButton!
	@IBOutlet weak var imageView: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
//		
//		self.scrollView.delegate = self
//		let scrollViewWidth:CGFloat = self.scrollView.frame.width
//		let scrollViewHeight:CGFloat = self.scrollView.frame.height
//		
//		let imgOne = UIImageView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:scrollViewHeight))
//		imgOne.image = #imageLiteral(resourceName: "ballons")
//		
//		let imgTwo = UIImageView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:scrollViewHeight))
//		imgTwo.image = #imageLiteral(resourceName: "party")
//		
//		self.scrollView.addSubview(imgOne)
//		self.scrollView.addSubview(imgTwo)
//		self.pageControl.currentPage = 0
	}
//	
//	//MARK: UIScrollView Delegate
//	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
//		// Test the offset and calculate the current page after scrolling ends
//		let pageWidth:CGFloat = scrollView.frame.width
//		let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
//		// Change the indicator
//		self.pageControl.currentPage = Int(currentPage);
//	
//		
//	}
//	
}
