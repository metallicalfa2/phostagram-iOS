//
//  CaptionViewController.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 06/08/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class CaptionViewController: UIViewController {

	@IBOutlet weak var imageView: UIImageView!
	var image: UIImage?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		if((image) != nil){
			imageView.image = image
		}
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	@IBAction func nextButtonPressed(_ sender: Any) {
	
	}
	
	@IBAction func backButtonPressed(_ sender: Any) {
	
	}
	
	
	override func prepare( for segue: UIStoryboardSegue, sender: Any?) {
		
		if segue.identifier == "captionNextToPreview", let destination = segue.destination as? PreviewViewController{
			destination.imageEl = image
		}
		
		
	}
	
	
	
	
	
	
	
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
