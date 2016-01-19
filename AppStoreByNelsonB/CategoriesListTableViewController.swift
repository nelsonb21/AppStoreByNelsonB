//
//  CategoriesListTableViewController.swift
//  AppStoreByNelsonB
//
//  Created by Nelson Bolivar on 13/1/16.
//  Copyright © 2016 Nelson Bolivar. All rights reserved.
//

import UIKit

class CategoriesListTableViewController: UITableViewController {

    let data:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var categoriesDictionary: [String:[NSDictionary]] = [String:[NSDictionary]]()
    var categoriesList: [String] = []
    var selectedRow: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateCategoriesList",name:"loadCategories", object: nil)
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
        return self.categoriesList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoriesCell", forIndexPath: indexPath)

        cell.textLabel?.text = self.categoriesList[indexPath.row]
        if(indexPath.row == self.selectedRow){
            cell.accessoryType = .Checkmark
        }else{
            cell.accessoryType = .None
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let categoryName = self.categoriesList[indexPath.row]
        self.data.setObject(self.categoriesDictionary[categoryName], forKey: "appsArray")
        NSNotificationCenter.defaultCenter().postNotificationName("loadApps", object: nil)
        self.selectedRow = indexPath.row;
        self.tableView.reloadData()
    }
    
    //MARK: - Custom Functions
    
    // Update categoriesList when a local notification is sent
    func updateCategoriesList(){
        self.categoriesDictionary = self.data.objectForKey("appsArray") as! [String:[NSDictionary]]
        for (key) in self.categoriesDictionary {
            self.categoriesList.append(key.0)
        }
        self.categoriesList.sortInPlace(<)
        self.tableView?.reloadData()
        NSNotificationCenter.defaultCenter().postNotificationName("loadApps", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("loadAppsIpad", object: nil)
    }
}
