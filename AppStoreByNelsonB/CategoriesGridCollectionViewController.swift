//
//  CategoriesGridCollectionViewController.swift
//  AppStoreByNelsonB
//
//  Created by Xpectra Remote managment. on 18/1/16.
//  Copyright © 2016 Nelson Bolivar. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CategoriesGridCollectionViewController: UICollectionViewController {

    let data:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var categoriesDictionary: [String:[NSDictionary]] = [String:[NSDictionary]]()
    var categoriesList: [String] = []
    let reuseIdentifier = "categoryCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateCollectionViewDataSource",name:"loadAppsIpad", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath = self.collectionView?.indexPathForCell(sender as! MyCustomCategoriesGridCell)
        let destinationNavigationController = segue.destinationViewController as! UINavigationController
        let appsListView = destinationNavigationController.topViewController as! AppsGridCollectionViewController
        
        appsListView.categoriesDictionary = self.categoriesDictionary
        appsListView.currentCategory = self.categoriesList[(indexPath?.row)!]
        if(self.categoriesList[(indexPath?.row)!] == "All"){
            appsListView.categoriesList = self.categoriesList
        }
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.categoriesList.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.reuseIdentifier, forIndexPath: indexPath) as! MyCustomCategoriesGridCell
        
        let item = self.categoriesDictionary[self.categoriesList[indexPath.row]]![0]
        
        cell.appTitle.text = self.categoriesList[indexPath.row]
        cell.appImage.layer.cornerRadius = 12
        cell.appImage.clipsToBounds = true
        
        if let url = NSURL(string: item["im:image"]![2]!["label"]! as! String) {
            if let data = NSData(contentsOfURL: url) {
                cell.appImage.image = UIImage(data: data)
            }
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    }
    
    // MARK: - Custom Function
    
    // Update collectionView data source when a local notification is sent
    func updateCollectionViewDataSource(){
        self.categoriesDictionary = self.data.objectForKey("appsArray") as! [String:[NSDictionary]]
        for (key) in self.categoriesDictionary {
            self.categoriesList.append(key.0)
        }
        self.categoriesList.sortInPlace(<)
        self.collectionView?.reloadData()
    }

}

// MARK: MyCustomCategoriesGridCell Class
//Custom class for Categories Grid View
class MyCustomCategoriesGridCell: UICollectionViewCell {
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var appImage: UIImageView!
}
