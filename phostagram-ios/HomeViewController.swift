//
//  HomeViewController.swift
//  phostagram-ios
//
//  Created by SKIXY-MACBOOK on 03/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
import ScalingCarousel
import AdobeCreativeSDKCore
import AdobeCreativeSDKImage
import Fusuma

class HomeViewController:UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, FusumaDelegate, AdobeUXImageEditorViewControllerDelegate{
	var isGridFlowLayoutUsed: Bool = false
	
	@IBOutlet weak var collection: ScalingCarouselView!
	
	@IBOutlet weak var listButton: UIButton!
	@IBOutlet weak var gridButton: UIButton!
	@IBOutlet weak var collectionView: UICollectionView!
	
	let fusuma = FusumaViewController()
	fileprivate let kCreativeSDKClientId = "6dadb592a209442f9db44920ca45f86a"
	fileprivate let kCreativeSDKClientSecret = "c11fa3fe-4e55-4cc5-9a27-3fe792c45dbd"
	fileprivate let kCreativeSDKRedirectURLString = "ams+4572f58a319441c5b5ab4cc2ad230c5b22d3e5d5://adobeid/6dadb592a209442f9db44920ca45f86a"
	
	/// Items to display
	var itemsToDisplay: [ImageToDisplay] = []
	/// Flow layout that displays cells with a Grid layout
	let gridFlowLayout = PhotoGridflowViewLayout()
	/// Flow layout that displays cells with a List layout, like in a tableView
	let listFlowLayout = PhotoListflowViewLayout()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		fusuma.delegate = self
		fusuma.cropHeightRatio = 0.6667
		fusuma.hasVideo = false
		fusuma.defaultMode = .library
		fusuma.allowMultipleSelection = false
		fusumaSavesImage = true
		fusumaCropImage = false
		fusumaBackgroundColor = UIColor.white
		fusumaTintColor = UIColor.gray
		fusumaBaseTintColor = UIColor.gray
		
		AdobeUXAuthManager.shared().setAuthenticationParametersWithClientID(kCreativeSDKClientId, withClientSecret: kCreativeSDKClientSecret)
		AdobeUXAuthManager.shared().redirectURL = NSURL(string: kCreativeSDKRedirectURLString)! as URL!
		
		
		setupDatasource()
		setupInitialLayout()
		self.newCardPressed(self)
	}
	
	@IBAction func newCardPressed(_ sender: Any) {
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
	}
	
	@IBAction func newOrder(_ sender: Any) {
		self.present(fusuma,animated:true,completion: nil)
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
		collection.collectionViewLayout = listFlowLayout
		
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
		DispatchQueue.main.async(
			execute: {
				//cell.imageView.dropShadow()
			}
		)
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

extension HomeViewController{
	func photoEditorStart(image: UIImage!) {
		DispatchQueue.main.async {
			AdobeImageEditorCustomization.setToolOrder([
				kAdobeImageEditorCrop,        /* Enhance */
				kAdobeImageEditorOrientation,
				kAdobeImageEditorEffects,
				kAdobeImageEditorColorAdjust,    /* Effects */
				kAdobeImageEditorSharpness
				])
			
			let adobeViewCtr = AdobeUXImageEditorViewController(image: image)
			adobeViewCtr.delegate = self as?  AdobeUXImageEditorViewControllerDelegate
			self.present(adobeViewCtr, animated: true) { () -> Void in
			}
		}
	}
	
	func photoEditor(_ editor: AdobeUXImageEditorViewController, finishedWith image: UIImage?)
	{
		self.dismiss(animated: true, completion: nil)
		//imageVIew.image = image
		
		
	}
	
	func photoEditorCanceled(_ editor: AdobeUXImageEditorViewController)
	{
		
	}
	
	
	
	
	// MARK: FusumaDelegate Protocol
	func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
		
		switch source {
			
		case .camera:
			
			print("Image captured from Camera")
			
		case .library:
			
			print("Image selected from Camera Roll")
			
		default:
			
			print("Image selected")
		}
		//print(image)
		
		DispatchQueue.main.async {
			AdobeImageEditorCustomization.setToolOrder([
				kAdobeImageEditorCrop,        /* Enhance */
				kAdobeImageEditorOrientation,
				kAdobeImageEditorEffects,
				kAdobeImageEditorColorAdjust,    /* Effects */
				kAdobeImageEditorSharpness
				])
			
			let adobeViewCtr = AdobeUXImageEditorViewController(image: image)
			adobeViewCtr.delegate = self as?  AdobeUXImageEditorViewControllerDelegate
			self.present(adobeViewCtr, animated: true) { () -> Void in
			}
		}
		
		//self.imageVIew.image = image
	}
	
	func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
		
		print("Number of selection images: \(images.count)")
		
		
	}
	
	func fusumaImageSelected(_ image: UIImage, source: FusumaMode, metaData: ImageMetadata) {
		
		print("Image mediatype: \(metaData.mediaType)")
		print("Source image size: \(metaData.pixelWidth)x\(metaData.pixelHeight)")
		print("Creation date: \(String(describing: metaData.creationDate))")
		print("Modification date: \(String(describing: metaData.modificationDate))")
		print("Video duration: \(metaData.duration)")
		print("Is favourite: \(metaData.isFavourite)")
		print("Is hidden: \(metaData.isHidden)")
		print("Location: \(String(describing: metaData.location))")
	}
	
	func fusumaVideoCompleted(withFileURL fileURL: URL) {
		
		print("video completed and output to file: \(fileURL)")
		//self.fileUrlLabel.text = "file output to: \(fileURL.absoluteString)"
	}
	
	func fusumaDismissedWithImage(_ image: UIImage, source: FusumaMode) {
		
		switch source {
			
		case .camera:
			
			print("Called just after dismissed FusumaViewController using Camera")
			
		case .library:
			
			print("Called just after dismissed FusumaViewController using Camera Roll")
			
		default:
			
			print("Called just after dismissed FusumaViewController")
		}
	}
	
	func fusumaCameraRollUnauthorized() {
		
		print("Camera roll unauthorized")
		
		let alert = UIAlertController(title: "Access Requested",
		                              message: "Saving image needs to access your photo album",
		                              preferredStyle: .alert)
		
		alert.addAction(UIAlertAction(title: "Settings", style: .default) { (action) -> Void in
			
			if let url = URL(string:UIApplicationOpenSettingsURLString) {
				
				UIApplication.shared.openURL(url)
			}
		})
		
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
			
		})
		
		self.present(alert, animated: true, completion: nil)
	}
	
	func fusumaClosed() {
		
		print("Called when the FusumaViewController disappeared")
	}
	
	func fusumaWillClosed() {
		
		print("Called when the close button is pressed")
	}
	

}
