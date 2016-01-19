//
//  PopoverViewController.swift
//  AppStoreByNelsonB
//
//  Created by Nelson Bolivar on 16/1/16.
//  Copyright © 2016 Nelson Bolivar. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {
    
    var appsDetails: NSDictionary = NSDictionary()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let detailViewImage = UIImageView(frame: CGRect(x: 8, y: 15, width: 75, height: 75))
        detailViewImage.layer.cornerRadius = 12
        detailViewImage.clipsToBounds = true
        if let url = NSURL(string: self.appsDetails["im:image"]![0]!["label"]! as! String) {
            if let data = NSData(contentsOfURL: url) {
                detailViewImage.image = UIImage(data: data)
            }
        }
        
        let detailAppTittle = UILabel(frame: CGRect(x: 91, y: 15, width: 250, height: 21))
        detailAppTittle.text = self.appsDetails["im:name"]!["label"] as? String
        detailAppTittle.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        detailAppTittle.textColor = UIColor.flatSkyBlueColor()
        
        let detailAppArtist = UILabel(frame: CGRect(x: 91, y: 42, width: 250, height: 21))
        detailAppArtist.text = "By: ".stringByAppendingString((self.appsDetails["im:artist"]!["label"] as? String)!)
        detailAppArtist.font = UIFont(name: "HelveticaNeue", size: 14)
        detailAppArtist.textColor = UIColor.flatSkyBlueColor()
        
        let detailAppCategory = UILabel(frame: CGRect(x: 91, y: 69, width: 250, height: 21))
        detailAppCategory.text = self.appsDetails["category"]!["attributes"]!!["label"] as? String
        detailAppCategory.font = UIFont(name: "HelveticaNeue", size: 14)
        detailAppCategory.textColor = UIColor.lightGrayColor()
        
        let detailAppReleaseDate = UILabel(frame: CGRect(x: 330, y: 15, width: 250, height: 21))
        detailAppReleaseDate.text = "Release Date: ".stringByAppendingString((self.appsDetails["im:releaseDate"]!["attributes"]!!["label"] as? String)!)
        detailAppReleaseDate.font = UIFont(name: "HelveticaNeue", size: 14)
        detailAppReleaseDate.textColor = UIColor.lightGrayColor()
        detailAppReleaseDate.textAlignment = .Right
        
        let verticalDivider = UIView(frame: CGRectMake(10, 105, self.view.bounds.size.width - 33, 2))
        verticalDivider.backgroundColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
        
        let detailAppSummary = UITextView(frame: CGRect(x: 20, y: 109, width: 560, height: 165))
        detailAppSummary.text = self.appsDetails["summary"]!["label"] as? String
        detailAppSummary.font = UIFont(name: "HelveticaNeue", size: 14)
        detailAppSummary.textAlignment = .Justified
        
        let detailAppRights = UILabel(frame: CGRect(x: 330, y: 280, width: 250, height: 21))
        detailAppRights.text = self.appsDetails["rights"]!["label"] as? String
        detailAppRights.font = UIFont(name: "HelveticaNeue", size: 14)
        detailAppRights.textColor = UIColor.flatSkyBlueColor()
        detailAppRights.textAlignment = .Right
        
        self.view.addSubview(detailViewImage)
        self.view.addSubview(detailAppTittle)
        self.view.addSubview(detailAppArtist)
        self.view.addSubview(detailAppCategory)
        self.view.addSubview(detailAppReleaseDate)
        self.view.addSubview(verticalDivider)
        self.view.addSubview(detailAppSummary)
        self.view.addSubview(detailAppRights)
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

}
