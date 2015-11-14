//
//  ViewController.swift
//  JSONTechTest
//
//  Created by Ronald Fischer on 11/13/15.
//  Copyright © 2015 qpiapps. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Test basic Alamofire functionality
        Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["foo": "bar"])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("AlamoFire JSON: \(JSON)")
                }
        }
        
        // Because of async nature of the calls this attempt at separation doesn't really do anything
        //print("\n\nAnd now for the SwiftyJSON version\n\n")
        
        // SwiftyJSON version
        Alamofire.request(.GET, "https://httpbin.org/get").validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("SwiftyJSON: \(json)")
                }
            case .Failure(let error):
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

