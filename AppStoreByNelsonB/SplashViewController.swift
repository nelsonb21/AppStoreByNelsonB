//
//  SplashViewController.swift
//  AppStoreByNelsonB
//
//  Created by Nelson Bolivar on 17/1/16.
//  Copyright © 2016 Nelson Bolivar. All rights reserved.
//

import UIKit
import ChameleonFramework

class SplashViewController: UIViewController {

    let data:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    let WebServer: WebService = WebService()
    @IBOutlet weak var appTitle1: UILabel!
    @IBOutlet weak var appTitle2: UILabel!
    @IBOutlet weak var appTitle3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        WebServer.getAppJson(){dataJSON in
            
            if let JSON = (NSKeyedUnarchiver.unarchiveObjectWithData(dataJSON) as? [String:[String:NSObject]]){
                var appsArray: [NSObject] = []
                appsArray.append(JSON["feed"]!["entry"]!)
                            
                let categoriesDictionary:[String:[NSDictionary]] = self.loadCategories(appsArray)
                self.data.setObject(categoriesDictionary, forKey: "appsArray")
                
                let delay = 3 * Double(NSEC_PER_SEC)
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(time, dispatch_get_main_queue()) {
                    self.performSegueWithIdentifier("principalSegue", sender: .None)
                    }
            }else{
                let delay = 3 * Double(NSEC_PER_SEC)
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(time, dispatch_get_main_queue()) {
                    self.performSegueWithIdentifier("principalSegue", sender: .None)
                }
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.view.backgroundColor = GradientColor(.LeftToRight, frame: self.view.frame, colors: [UIColor.flatSkyBlueColor(),UIColor.flatGreenColor()])
        
        UIView.animateWithDuration(3.0, animations: {
            self.appTitle1.frame = CGRect(x: 320-50, y: 120, width: 50, height: 50)
            self.appTitle2.frame = CGRect(x: 50, y: 120, width: 50, height: 50)
            self.appTitle3.frame = CGRect(x: 320-50, y: 120, width: 50, height: 50)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        segue.destinationViewController as! PrincipalViewController
    }
    
    //MARK: - Custom Functions

    //Load Categories Into Array
    func loadCategories(appsArray: [NSObject]) -> [String:[NSDictionary]] {
        
        var categoriesArray: [String:[NSDictionary]] = [String:[NSDictionary]]()
        categoriesArray["All"] = [NSMutableDictionary]()
        
        let items = appsArray[0] as! [NSObject]
        for (var i = 0; i < items.count; i++){
            
            let item:NSDictionary = items[i] as! NSDictionary
            let category: String = item["category"]!["attributes"]!!["label"] as! String
            
            if( categoriesArray[category] == nil ){
                
                categoriesArray[category] = [NSDictionary]()
                categoriesArray[category]?.append(item)
                categoriesArray["All"]?.append(item)
                
            }else{
                categoriesArray[category]?.append(item)
                categoriesArray["All"]?.append(item)
            }
        }
        return categoriesArray
    }

}
