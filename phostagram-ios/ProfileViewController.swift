//
//  ProfileViewController.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 30/06/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

struct ImageToDisplay {
	var imageName: String
}

class ProfileViewController: UIViewController,UICollectionViewDataSource {
	var collectionViewHeight: CGFloat?
	var isGridFlowLayoutUsed: Bool = false

	@IBOutlet weak var listButton: UIButton!
	@IBOutlet weak var gridButton: UIButton!
	@IBOutlet weak var collectionView: UICollectionView!
	
	/// Items to display
	var itemsToDisplay: [ImageToDisplay] = []
	/// Flow layout that displays cells with a Grid layout
	let gridFlowLayout = PhotoGridflowViewLayout()
	/// Flow layout that displays cells with a List layout, like in a tableView
	let listFlowLayout = PhotoListflowViewLayout()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupDatasource()
		setupInitialLayout()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		//collectionViewHeight = self.collectionView.collectionViewLayout.collectionViewContentSize.height
		//self.collectionView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.old, context: nil)

	}
	
	@IBAction func listButtonPressed(_ sender: Any) {
		isGridFlowLayoutUsed = false
		gridButton.setImage(#imageLiteral(resourceName: "gridNotSelected"), for: .normal)
		listButton.setImage(#imageLiteral(resourceName: "listSelected"), for: .normal)
		//listButton.setImage(UIImage(named: "listSelected.jpg"), for: .normal)
		UIView.animate(withDuration: 0.2, animations: { () -> Void in
			self.collectionView.collectionViewLayout.invalidateLayout()
			self.collectionView.setCollectionViewLayout(self.listFlowLayout, animated: true)
		})
	}
	@IBAction func gridButtonPressed(_ sender: Any) {
		isGridFlowLayoutUsed = true
		listButton.setImage(#imageLiteral(resourceName: "listNotSelected"), for: .normal)
		gridButton.setImage(#imageLiteral(resourceName: "gridSelected"), for: .normal)
		//gridButton.setImage(UIImage(named:"gridSelected.jpg"), for: .normal)
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
	
	
}

extension ProfileViewController{
	// MARK: collectionView methods
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! photoCollectionViewCell
		
		let itemToDisplay = itemsToDisplay[indexPath.row]
		cell.imageView.image = UIImage(named: "\(itemToDisplay.imageName)"+".jpg")
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return itemsToDisplay.count
	}
	
	override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
		collectionView.collectionViewLayout.invalidateLayout()
	}
}
