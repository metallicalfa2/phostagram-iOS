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
	
	override init() {
		super.init()
		setupLayout()
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
		minimumLineSpacing = 1
		scrollDirection = .vertical
	}
	
	func itemWidth() -> CGFloat {
		return collectionView!.frame.width
	}
	
	override var itemSize: CGSize {
		set {
			self.itemSize = CGSize(width: itemWidth(), height: itemHeight)
		}
		get {
			return CGSize(width: itemWidth(), height: itemHeight)
		}
	}
	
	override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
		return collectionView!.contentOffset
	}
}
