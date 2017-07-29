//
//  HomeViewController.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 03/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
import ScalingCarousel

class HomeViewController:UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
	var isGridFlowLayoutUsed: Bool = false
	
	@IBOutlet weak var collection: ScalingCarouselView!
	
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
	}
	
	
	@IBAction func listButtonPressed(_ sender: Any) {
		isGridFlowLayoutUsed = false
		gridButton.setImage(#imageLiteral(resourceName: "gridNotSelected"), for: .normal)
		listButton.setImage(#imageLiteral(resourceName: "listSelected"), for: .normal)
	
		UIView.animate(withDuration: 0.2, animations: { () -> Void in
			self.collection.collectionViewLayout.invalidateLayout()
			self.collection.setCollectionViewLayout(self.listFlowLayout, animated: true)
		})
	}
	@IBAction func gridButtonPressed(_ sender: Any) {
		isGridFlowLayoutUsed = true
		listButton.setImage(#imageLiteral(resourceName: "listNotSelected"), for: .normal)
		gridButton.setImage(#imageLiteral(resourceName: "gridSelected"), for: .normal)
		var grid = PhotoGridflowViewLayout()
		
		UIView.animate(withDuration: 0.2, animations: { () -> Void in
			self.collection.collectionViewLayout.invalidateLayout()
			self.collection.setCollectionViewLayout(grid, animated: true)
		})
	}
	
	
	func setupDatasource() {
		itemsToDisplay = [ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island")]
		
		collection.reloadData()
	}
	 
	func setupInitialLayout() {
		isGridFlowLayoutUsed = true
		//gridFlowLayout.sectionInset = UIEdgeInsetsMake(0,10,0,10)
		collection.collectionViewLayout = gridFlowLayout
		
		gridFlowLayout.scrollDirection = .vertical
		listFlowLayout.scrollDirection = .horizontal
	}
	
}

extension HomeViewController{
	// MARK: collectionView methods
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! photoCollectionViewCell
		let itemToDisplay = itemsToDisplay[indexPath.row]
		
		cell.imageView.image = UIImage(named: "\(itemToDisplay.imageName)"+".jpg")
		(isGridFlowLayoutUsed == true ) ? cell.imageView.cornerRadius(radius: 2) : cell.imageView.cornerRadius(radius: 0)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return itemsToDisplay.count
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		collection.didScroll()
	}
}


