//
//  AppsDetailsViewController.swift
//  AppStoreByNelsonB
//
//  Created by Nelson Bolivar on 14/1/16.
//  Copyright © 2016 Nelson Bolivar. All rights reserved.
//

import UIKit

class AppsDetailsViewController: UIViewController {

    
    @IBOutlet weak var detailViewTitle: UINavigationItem!
    @IBOutlet weak var detailHeaderView: UIView!
    @IBOutlet weak var detailViewImage: UIImageView!
    @IBOutlet weak var detailAppTittle: UILabel!
    @IBOutlet weak var detailAppCategory: UILabel!
    @IBOutlet weak var detailAppArtist: UILabel!
    @IBOutlet weak var detailAppReleaseDate: UILabel!
    @IBOutlet weak var detailAppSummary: UITextView!
    @IBOutlet weak var detailAppRights: UILabel!
    
    @IBOutlet weak var detailAppNavigationBar: UINavigationBar!
    var appsDetails: NSDictionary = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.detailViewTitle.title = self.appsDetails["im:name"]!["label"] as? String
        self.navigationController?.navigationBar.backgroundColor = UIColor.flatGreenColor()
        self.detailAppNavigationBar.barTintColor = UIColor.flatGreenColor()
        self.detailAppNavigationBar.tintColor = UIColor.whiteColor()
        self.detailAppNavigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        self.detailAppTittle.text = self.appsDetails["im:name"]!["label"] as? String
        self.detailAppArtist.text = "By: ".stringByAppendingString((self.appsDetails["im:artist"]!["label"] as? String)!)
        self.detailAppCategory.text = self.appsDetails["category"]!["attributes"]!!["label"] as? String
        self.detailAppReleaseDate.text = "Release Date: ".stringByAppendingString((self.appsDetails["im:releaseDate"]!["attributes"]!!["label"] as? String)!)
        self.detailViewImage.layer.cornerRadius = 12
        self.detailViewImage.clipsToBounds = true
        
        if let url = NSURL(string: self.appsDetails["im:image"]![0]!["label"]! as! String) {
            if let data = NSData(contentsOfURL: url) {
                self.detailViewImage.image = UIImage(data: data)
            }
        }
        
        let verticalDivider = UIView(frame: CGRectMake(10, 84, self.view.bounds.size.width - 20, 1))
        verticalDivider.backgroundColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
        
        self.detailHeaderView.addSubview(verticalDivider)
        
        self.detailAppSummary.text = self.appsDetails["summary"]!["label"] as? String
        self.detailAppRights.text = self.appsDetails["rights"]!["label"] as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func backButton(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
