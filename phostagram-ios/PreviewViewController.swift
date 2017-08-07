//
//  PreviewViewController.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 07/08/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

	@IBOutlet weak var details: UILabel!
	@IBOutlet weak var recipients: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		details.layer.addBorder(edge: .bottom, color: UIColor.lightGray , thickness: 0.5)
		recipients.layer.addBorder(edge: .bottom, color: UIColor.lightGray , thickness: 0.5)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	
	@IBAction func expandPressed(_ sender: Any) {
	}
}
