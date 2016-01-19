//
//  AppsGridCollectionViewController.swift
//  AppStoreByNelsonB
//
//  Created by Nelson Bolivar on 15/1/16.
//  Copyright © 2016 Nelson Bolivar. All rights reserved.
//

import UIKit
import ChameleonFramework

class AppsGridCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIPopoverPresentationControllerDelegate {
    
    let data:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    let reuseIdentifier = "AppCell"
    var categoriesDictionary: [String:[NSDictionary]] = [String:[NSDictionary]]()
    var categoriesList: [String] = []
    var popoverViewController : PopoverViewController?
    var currentCategory: String = ""
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.backgroundColor = UIColor.flatGreenColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.flatGreenColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.navigationBar.title = self.currentCategory
        self.collectionView?.backgroundColor = GradientColor(.LeftToRight, frame: self.view.frame, colors: [UIColor.flatWhiteColor(),UIColor.flatWhiteColorDark(), UIColor.flatGrayColor(), UIColor.flatGrayColorDark()])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if(self.currentCategory == "All"){
            self.categoriesDictionary.removeValueForKey("All")
            self.categoriesList.removeAtIndex(0)
            return self.categoriesList.count
        }else{
            return 1
        }
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if(self.currentCategory == "All"){
            return self.categoriesDictionary[self.categoriesList[section]]!.count
        }else{
            return self.categoriesDictionary[currentCategory]!.count
        }
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.reuseIdentifier, forIndexPath: indexPath) as! MyCustomAppsGridCell
        
        let item: NSDictionary
        if(self.currentCategory == "All"){
            item = self.categoriesDictionary[self.categoriesList[indexPath.section]]![indexPath.row] as NSDictionary
        }else{
            item = self.categoriesDictionary[currentCategory]![indexPath.row] as NSDictionary
        }
        
        cell.appTitle.text = item["im:name"]!["label"] as? String
        cell.appImage.layer.cornerRadius = 12
        cell.appImage.clipsToBounds = true
        
        if let url = NSURL(string: item["im:image"]![2]!["label"]! as! String) {
            if let data = NSData(contentsOfURL: url) {
                cell.appImage.image = UIImage(data: data)
            }
        }
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView: AppsHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "CategoryTitle", forIndexPath: indexPath) as! AppsHeaderView
        if(self.currentCategory == "All"){
            headerView.categoryTitle.text = self.categoriesList[indexPath.section]
            headerView.appsNumber.text = String(self.categoriesDictionary[self.categoriesList[indexPath.section]]!.count)
        }else{
            headerView.categoryTitle.text = self.currentCategory
            headerView.appsNumber.text = String(self.categoriesDictionary[self.currentCategory]!.count)
        }
        
        headerView.backgroundColor = UIColor.flatSkyBlueColor()
        return headerView
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.showAppDetail(indexPath)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    //MARK: Navigation
    
    @IBAction func backAction(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: - Custom Functions
    
    // Display the popover with the app description
    func showAppDetail(indexPath: NSIndexPath){
        let cell = self.collectionView!.cellForItemAtIndexPath(indexPath) as! MyCustomAppsGridCell
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        let popoverViewController: PopoverViewController = storyboard.instantiateViewControllerWithIdentifier("AppDescription") as! PopoverViewController
        
        let item: NSDictionary
        if(self.currentCategory == "All"){
            item = self.categoriesDictionary[self.categoriesList[indexPath.section]]![indexPath.row] as NSDictionary
        }else{
            item = self.categoriesDictionary[currentCategory]![indexPath.row] as NSDictionary
        }
        
        popoverViewController.appsDetails = item
        
        popoverViewController.modalPresentationStyle = .Popover
        popoverViewController.preferredContentSize = CGSizeMake(600, 321)
        
        let popoverDetailViewController = popoverViewController.popoverPresentationController
        popoverDetailViewController?.permittedArrowDirections = .Any
        popoverDetailViewController?.delegate = self
        popoverDetailViewController?.sourceView = cell
        
        popoverDetailViewController?.sourceRect = CGRect(x: cell.appImage.layer.position.x + 10,y: cell.appImage.layer.position.y + 10,width: 1,height: 1)
        
        presentViewController(popoverViewController,animated: true,completion: nil)
    }
}

// MARK: MyCustomAppsGridCell Class
//Custom class for Apps cell in Grid View
class MyCustomAppsGridCell: UICollectionViewCell {
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var appImage: UIImageView!
}

// MARK: AppsHeaderView Class
//Custom class for Apps Header View
class AppsHeaderView: UICollectionReusableView {
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var appsNumber: UILabel!
}
