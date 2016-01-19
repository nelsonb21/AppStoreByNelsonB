//
//  ViewController.swift
//  AppStoreByNelsonB
//
//  Created by Nelson Bolivar on 13/1/16.
//  Copyright © 2016 Nelson Bolivar. All rights reserved.
//

import UIKit
import ChameleonFramework

class PrincipalViewController: UIViewController {
    
    @IBOutlet weak var appsHeader: UINavigationBar!
    @IBOutlet weak var appsContainer: UIView!
    @IBOutlet weak var categoriesHeader: UINavigationBar!
    @IBOutlet weak var ipadHeader: UINavigationBar!
    @IBOutlet weak var ipadContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.appsHeader.barTintColor = UIColor.flatGreenColor()
        self.appsHeader.backgroundColor = UIColor.flatGreenColor()
        
        self.categoriesHeader.barTintColor = UIColor.flatSkyBlueColor()
        self.categoriesHeader.backgroundColor = UIColor.flatSkyBlueColor()
        
        self.ipadHeader.barTintColor = UIColor.flatGreenColor()
        self.ipadHeader.backgroundColor = UIColor.flatGreenColor()
        
        self.ipadContainer.backgroundColor = GradientColor(.LeftToRight, frame: self.view.frame, colors: [UIColor.flatWhiteColor(),UIColor.flatWhiteColorDark(), UIColor.flatGrayColor(), UIColor.flatGrayColorDark()])
        
        self.view.backgroundColor = UIColor.flatGreenColor()
        
        NSNotificationCenter.defaultCenter().postNotificationName("loadCategories", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
}

