//
//  WebService.swift
//  AppStoreByNelsonB
//
//  Created by Nelson Bolivar on 13/1/16.
//  Copyright © 2016 Nelson Bolivar. All rights reserved.
//

import Foundation
import Alamofire

class WebService{
    var baseURL: String = "https://itunes.apple.com/us/rss/topfreeapplications/limit=20/json"
    
    let data:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    func getAppJson(completion:(response: NSData) -> ()){
        Alamofire.request(.GET, baseURL).responseJSON(){
            response in

            switch response.result {
            case .Success( _):
                //print("Success")
                let dato: NSData = NSKeyedArchiver.archivedDataWithRootObject(response.result.value!)
                completion(response: dato)

            case .Failure( _):
                //print("Request failed with error: \(error)")
                //print("Failure")
                let dato: NSData = NSData()
                completion(response: NSKeyedArchiver.archivedDataWithRootObject(dato))
            }
        }
    }
}