//
//  ProfileViewController.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 30/06/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
import Alamofire


struct ImageToDisplay {
	var imageName: String
}

class ProfileViewController: UIViewController,UICollectionViewDataSource {
	var isGridFlowLayoutUsed: Bool = false

	@IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
	
	@IBOutlet weak var parentView: UIView!
	@IBOutlet weak var listButton: UIButton!
	@IBOutlet weak var gridButton: UIButton!
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var noOfPhostagram: UILabel!
	@IBOutlet weak var name: UILabel!
	@IBOutlet weak var gender: UILabel!
	@IBOutlet weak var age: UILabel!
	@IBOutlet weak var interests: UILabel!
	@IBOutlet weak var phoneNumber: UILabel!
	@IBOutlet weak var email: UILabel!
	
	@IBOutlet weak var profileImg: UIImageView!
	/// Items to display
	var itemsToDisplay: [ImageToDisplay] = []
	/// Flow layout that displays cells with a Grid layout
	let gridFlowLayout = PhotoGridflowViewLayout()
	/// Flow layout that displays cells with a List layout, like in a tableView
	let listFlowLayout = PhotoListflowViewLayout()
	
	let profile = profileModel.sharedInstance
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupDatasource()
		setupInitialLayout()
		fetchDetails()
		collectionView.heroModifiers = [.cascade]
		self.profileImg.roundCorners()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
	}
	
	
	@IBAction func listButtonPressed(_ sender: Any) {
		isGridFlowLayoutUsed = false
		gridButton.setImage(#imageLiteral(resourceName: "gridNotSelected"), for: .normal)
		listButton.setImage(#imageLiteral(resourceName: "listSelected"), for: .normal)
		
		UIView.animate(withDuration: 0.2, animations: { () -> Void in
			self.collectionView.collectionViewLayout.invalidateLayout()
			self.collectionView.setCollectionViewLayout(self.listFlowLayout, animated: true)
		})
	}
	@IBAction func gridButtonPressed(_ sender: Any) {
		isGridFlowLayoutUsed = true
		listButton.setImage(#imageLiteral(resourceName: "listNotSelected"), for: .normal)
		gridButton.setImage(#imageLiteral(resourceName: "gridSelected"), for: .normal)

		UIView.animate(withDuration: 0.2, animations: { () -> Void in
			self.collectionView.collectionViewLayout.invalidateLayout()
			self.collectionView.setCollectionViewLayout(self.gridFlowLayout, animated: true)
		})
	}


	func setupDatasource() {
		itemsToDisplay = [ImageToDisplay(imageName: "ballons"),ImageToDisplay(imageName: "party"),ImageToDisplay(imageName: "ballons"),ImageToDisplay(imageName: "party"),ImageToDisplay(imageName: "ballons"),ImageToDisplay(imageName: "party"),ImageToDisplay(imageName: "ballons"),ImageToDisplay(imageName: "party"),ImageToDisplay(imageName: "ballons"),ImageToDisplay(imageName: "party")]
		
		collectionView.reloadData()
	}
	
	func setupInitialLayout() {
		isGridFlowLayoutUsed = true
		collectionView.collectionViewLayout = gridFlowLayout
	}
	
	func fetchDetails(){
		self.name.text = profile.name
		self.email.text = profile.email
		self.age.text = profile.dob
		self.phoneNumber.text = profile.phoneNumber
		self.interests.text = profile.interests?.reduce("", {$0 + " " + $1})
		//self.profileImg.imageFromServerURL(url: URL(string: profile.profilePic!) ?? )
	}
	
}

extension ProfileViewController{
	// MARK: collectionView methods
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! photoCollectionViewCell
		
		let itemToDisplay = itemsToDisplay[indexPath.row]
		
		cell.imageView.image = UIImage(named: "\(itemToDisplay.imageName)"+".jpg")
		(isGridFlowLayoutUsed == true ) ? cell.imageView.cornerRadius(radius: 5) : cell.imageView.cornerRadius(radius: 0)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return itemsToDisplay.count
	}
	
}
