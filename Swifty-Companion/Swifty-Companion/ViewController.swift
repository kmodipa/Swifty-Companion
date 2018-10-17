//
//  ViewController.swift
//  Swifty-Companion
//
//  Created by Khomotjo MODIPA on 2018/10/17.
//  Copyright © 2018 Khomotjo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /* Properties */
    var token: String!
    
    /* Request Functions */
    
    @IBAction func searchLogin(_ sender: UIButton) {
        
    }
    
    func tokenRequest() -> String {
        let UID = "2478bbe3602f3c04b8966893d58cb39c24c0a862ed4a0e556e5e55e7a6246c32"
        let SECRET = "343a60d286731fbf19013b05663665c1f1edc57ba05c3191349d0f2b580113d0"
        let BEARER = ((UID + ":" + SECRET).data(using: String.Encoding.utf8, allowLossyConversion: true))!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        
        
        guard let url = URL(string: "https://api.intra.42.fr/oauth/token") else {return "Failed to get token URL"}
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    
                    if let token = json["access_token"]
                    {
                        print(token)
                        self.token = token as! String
                    }
                } catch {
                    print(error)
                }
            }
        })
        
        task.resume()
        return self.token
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(tokenRequest())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

