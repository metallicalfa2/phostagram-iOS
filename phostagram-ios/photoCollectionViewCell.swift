//
//  photoCollectionViewCell.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 03/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class photoCollectionViewCell: UICollectionViewCell{
	@IBOutlet var imageView: UIImageView!

	override func prepareForReuse() {
		super.prepareForReuse()
		imageView.image = nil
	}
}
