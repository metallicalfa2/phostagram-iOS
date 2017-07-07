//
//  AddNewContactViewController.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 05/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class AddNewContactController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
	let picker = UIImagePickerController()
	
	@IBOutlet weak var name: UITextField!
	@IBOutlet weak var gender: UITextField!
	@IBOutlet weak var ageGroup: UITextField!
	@IBOutlet weak var phone: UITextField!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var address: UITextField!
	@IBOutlet weak var pincode: UITextField!
	@IBOutlet weak var cancel: UIBarButtonItem!
	@IBAction func cancelPressed(_ sender: Any) {
	//	self.dismiss(animated: true, completion: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		imageView.roundCorners()
		picker.delegate = self
		
		imageView.isUserInteractionEnabled = true
		let tap = UITapGestureRecognizer(target: self, action: #selector(editImage))
		imageView.addGestureRecognizer(tap)
	}
	
	func editImage(){
		picker.allowsEditing = true
		picker.sourceType = .photoLibrary
		picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
		present(picker, animated: true, completion: nil)
	}
	
	func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any])
	{
		if let chosenImage = info[UIImagePickerControllerEditedImage] as? UIImage{
			self.imageView.image = chosenImage
		}
		else if let chosenImage = info[UIImagePickerControllerEditedImage] as? UIImage{
			self.imageView.image = chosenImage
		}
		else{
			print("Error")
		}
		dismiss(animated:true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true, completion: nil)
		
	}
}
