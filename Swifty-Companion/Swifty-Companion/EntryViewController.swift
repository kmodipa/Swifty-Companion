//
//  EntryViewController.swift
//  Swifty-Companion
//
//  Created by Asahel RANGARIRA on 2018/10/19.
//  Copyright © 2018 Khomotjo. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

    /* Properties */
    var apiController: APIController = APIController()
    
    /* ViewController Properties */
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func searchButton(_ sender: UIButton) {
        
        if self.searchTextField.text?.isEmpty ?? true {
            DispatchQueue.main.async {
                self.popUp()
            }
            
            print("Text field can't be empty")
        }
        else {
            
            let returned = self.apiController.getUserInfo(userlogin: (searchTextField.text!.trimmingCharacters(in: .whitespaces)).lowercased(), token: globals.token) {
                (output, error) in
                if let data = output {
                    DispatchQueue.main.async {
                        print(data)
                        self.performSegue(withIdentifier: "mySegue", sender: self)
                    }
                }
                else {
                    DispatchQueue.main.async {
                        self.popUp() /* pop-up an alert message */
                    }
                }
            }
            
            if !returned.result {
                self.apiController.requestToken() /* follow up request */
                print("Fails")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.apiController.requestToken() /* first request */
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
