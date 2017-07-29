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
//		
//		let leftSwipeGest = UISwipeGestureRecognizer(target: self, action: #selector(funcForGesture))
//		leftSwipeGest.direction = .left
//		collectionView.addGestureRecognizer(leftSwipeGest)
		
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
		
		UIView.animate(withDuration: 0.2, animations: { () -> Void in
			self.collection.collectionViewLayout.invalidateLayout()
			self.collection.setCollectionViewLayout(self.gridFlowLayout, animated: true)
		})
	}
	
	
	func setupDatasource() {
		itemsToDisplay = [ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island"),ImageToDisplay(imageName: "island")]
		
		collection.reloadData()
	}
	 
	func setupInitialLayout() {
		isGridFlowLayoutUsed = true
		//gridFlowLayout.sectionInset = UIEdgeInsetsMake(0,10,0,10)
		collection.collectionViewLayout = listFlowLayout
		
		gridFlowLayout.scrollDirection = .vertical
		listFlowLayout.scrollDirection = .horizontal
	}
	
	func funcForGesture(_ sender:UISwipeGestureRecognizer){
		print("swiped")
		if sender.direction == .left {
			//scroll to next item
			print("left swipped")
			let cellItems = self.collectionView.indexPathsForVisibleItems
			print(cellItems)
			self.collectionView.scrollToItem(at: cellItems.max()!, at: .right, animated: true)
			
			let cellSize = CGSize(width: self.view.frame.width,height: self.view.frame.height);
			
			//get current content Offset of the Collection view
			let contentOffset = collectionView.contentOffset;
			
			//scroll to next cell
			//self.collectionView.scrollRectToVisible(CGRect(x: 50, y: 0,width: cellSize.width - 100 , height: cellSize.height), animated: true);
			

		}
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


