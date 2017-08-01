//
//  PhotoListflowViewLayout.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 03/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class PhotoListflowViewLayout: UICollectionViewFlowLayout{
	
	let itemHeight: CGFloat = 240
	let phoneHeight = UIScreen.main.bounds.height
	open var inset: CGFloat = 20

	override init() {
		super.init()
		setupLayout()
	}
	
	convenience init(withCarouselInset inset: CGFloat = 0.0) {
		self.init()
		self.inset = inset
	}
	
	/**
	Init method
	
	- parameter aDecoder: aDecoder
	
	- returns: self
	*/
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupLayout()
	}
	
	/**
	Sets up the layout for the collectionView. 0 distance between each cell, and vertical layout
	*/
	func setupLayout() {
		minimumInteritemSpacing = 0
		minimumLineSpacing = 0
		scrollDirection = .horizontal
		sectionInset = UIEdgeInsets(top: 0.0, left: inset, bottom: 0.0, right: inset)
		footerReferenceSize = CGSize.zero
		headerReferenceSize = CGSize.zero
	}
	
	func itemWidth() -> CGFloat {
		return collectionView!.frame.width - (inset*2)
	}
	
	func height() -> CGFloat{
		if (phoneHeight < 667) {
			return 380
		} else if (phoneHeight < 736) {
			return 420
		} else {
			return 440
		}
	}
	
	override var itemSize: CGSize {
		set {
			self.itemSize = CGSize(width: itemWidth(), height: itemWidth()*0.666)
		}
		get {
			return CGSize(width: itemWidth(), height: itemWidth()*0.666)
		}
	}
	
	override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
		return collectionView!.contentOffset
	}
}
