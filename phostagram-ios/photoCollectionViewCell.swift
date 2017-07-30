//
//  photoCollectionViewCell.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 03/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
import ScalingCarousel

class photoCollectionViewCell: ScalingCarouselCell{

	@IBOutlet var imageView: UIImageView!
	@IBOutlet weak var likButton: UIView!
	@IBOutlet weak var shareButton: UILabel!
	
	override func prepareForReuse() {
		super.prepareForReuse()
		imageView.image = nil
	}
}
