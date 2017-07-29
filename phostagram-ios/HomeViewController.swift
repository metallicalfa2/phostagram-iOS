//
//  HomeViewController.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 03/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class HomeViewController:UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
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
		collectionView.heroModifiers = [.cascade]
		
		let leftSwipeGest = UISwipeGestureRecognizer(target: self, action: #selector(funcForGesture))
		leftSwipeGest.direction = .left
		collectionView.addGestureRecognizer(leftSwipeGest)
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
		itemsToDisplay = [ImageToDisplay(imageName: "ballons"),ImageToDisplay(imageName: "party"),ImageToDisplay(imageName: "ballons"),ImageToDisplay(imageName: "party"),ImageToDisplay(imageName: "ballons"),ImageToDisplay(imageName: "party"),ImageToDisplay(imageName: "ballons"),ImageToDisplay(imageName: "party"),ImageToDisplay(imageName: "ballons"),ImageToDisplay(imageName: "party"),ImageToDisplay(imageName: "ballons"),ImageToDisplay(imageName: "party"),ImageToDisplay(imageName: "ballons"),ImageToDisplay(imageName: "party"),ImageToDisplay(imageName: "ballons"),ImageToDisplay(imageName: "party"),ImageToDisplay(imageName: "ballons")]
		
		collectionView.reloadData()
	}
	
	func setupInitialLayout() {
		isGridFlowLayoutUsed = true
		gridFlowLayout.sectionInset = UIEdgeInsetsMake(0,10,0,10)
		collectionView.collectionViewLayout = listFlowLayout
		
		gridFlowLayout.scrollDirection = .vertical
		listFlowLayout.scrollDirection = .horizontal
	}
	
	func funcForGesture(_ sender:UISwipeGestureRecognizer){
		if sender.direction == .left {
			//scroll to next item
			print("left swipped")
			let cellItems = self.collectionView.indexPathsForVisibleItems
			
			self.collectionView.scrollToItem(at: cellItems.max()!, at: .centeredHorizontally, animated: true)
		}
	}
	
}

extension HomeViewController{
	// MARK: collectionView methods
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! photoCollectionViewCell

		//cell.heroModifiers = [.fade, .scale(0.5)]
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
