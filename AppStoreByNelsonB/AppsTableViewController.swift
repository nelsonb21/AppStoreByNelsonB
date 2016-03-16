//
//  AppsTableViewController.swift
//  AppStoreByNelsonB
//
//  Created by Nelson Bolivar on 13/1/16.
//  Copyright © 2016 Nelson Bolivar. All rights reserved.
//

import UIKit

class AppsTableViewController: UITableViewController {
    
    let data:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var appsArray:[NSObject] = [NSObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateAppsArray",name:"loadApps", object: nil)
        self.tableView?.rowHeight = 64.0
        let x = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.appsArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AppsTableCell", forIndexPath: indexPath) as! MyCustomAppsTableCell
        
        let item = self.appsArray[indexPath.row] as! NSDictionary
        
        cell.appTitle?.text = item["im:name"]!["label"] as? String
        cell.appCategory?.text = item["category"]!["attributes"]!!["label"] as? String
        
        cell.appImage?.layer.cornerRadius = 12
        cell.appImage?.clipsToBounds = true
        
        if let url = NSURL(string: item["im:image"]![2]!["label"]! as! String) {
            if let data = NSData(contentsOfURL: url) {
                cell.appImage?.image = UIImage(data: data)
            }        
        }
        cell.accessoryType = .DetailButton
        return cell
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showAppDetail", sender: indexPath)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destViewController: AppsDetailsViewController = segue.destinationViewController as! AppsDetailsViewController
        
        if let row = self.tableView.indexPathForSelectedRow?.row {
            destViewController.appsDetails = self.appsArray[row] as! NSDictionary
        }else
        {
            destViewController.appsDetails = self.appsArray[sender!.row] as! NSDictionary
        }
    }
    
    //MARK: - Custom Functions
    
    // Update appsArray when a local notification is sent
    func updateAppsArray(){
        if let appList = self.data.objectForKey("appsArray") as? [String:[NSDictionary]]{
            self.appsArray = appList["All"]!
        }else{
            self.appsArray = self.data.objectForKey("appsArray") as! [NSObject]
        }
        self.tableView?.reloadData()
    }
}

// MARK: AppsTableCell Class
//Custom class for apps table View
class MyCustomAppsTableCell: UITableViewCell {
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var appCategory: UILabel!
    @IBOutlet weak var appImage: UIImageView!
}
