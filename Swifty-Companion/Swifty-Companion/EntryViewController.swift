//
//  EntryViewController.swift
//  Swifty-Companion
//
//  Created by Asahel RANGARIRA on 2018/10/19.
//  Copyright © 2018 Khomotjo. All rights reserved.
//

import UIKit
import SwiftyJSON

class EntryViewController: UIViewController {

    /* Properties */
    var access_token: String!
    var json: JSON!
    var apiController: APIController = APIController()
    
    /* ViewController Properties */
    @IBOutlet weak var searchTextField: UITextField!

    /* Request Search */
    @IBAction func searchButton(_ sender: UIButton) {
        
        if self.searchTextField.text?.isEmpty ?? true {
            self.popUp()
            print("Text field can't be empty")
        }
        else {
            print(apiController.getUserInfo(userlogin: (searchTextField.text!.trimmingCharacters(in: .whitespaces)).lowercased(), token: globals.token))
            print(globals.jsonResponse)
            performSegue(withIdentifier: "mySegue", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiController.requestToken() /* first request */

        print("View loaded")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mySegue" {
            let destination = segue.destination as? ViewController
            destination?.user = searchTextField.text!
        }
    }
    
    func popUp()
    {
        var alert = UIAlertController()
        let message = "The username:  " + self.searchTextField.text! + " was not found. Please try again..."
        if self.searchTextField.text?.isEmpty ?? true
        {
            alert = UIAlertController(title: "No Username", message: "Username text field can't be empty!", preferredStyle: .alert)
        }
        else
        {
            alert = UIAlertController(title: "Username Error", message: message, preferredStyle: .alert)
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    

}
